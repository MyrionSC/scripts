using System;
using System.Threading.Tasks;
using System.IO;
using System.Collections.Generic;
using Microsoft.Azure.Storage.Blob;
using System.Linq;
using dk.fp.pinfo.sl;
using Microsoft.Azure.Storage;
using dk.fp.pinfo.util;
using Microsoft.Azure.Storage.RetryPolicies;
using System.Text;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using dk.fp.pinfo.dtl;

namespace dk.fp.pinfo.blobs
{
    public class AzureBlobStoreService : IBlobStoreService
    {
        public const string ContainerName = "pinfo-store-v1";

        CloudStorageAccount _account;
        CloudBlobClient _client;
        CloudBlobContainer _container;
        BlobContainerPermissions _permissions;

        public AzureBlobStoreService(ISecretSettingsService secretSettings)
        {
            string connectionString = secretSettings.GetSecret(SecretSettingsKeys.BlobStoreConnectionString);

            if (!CloudStorageAccount.TryParse(connectionString, out _account))
                throw new ArgumentException($"Could not parse connection string. Please verify secret setting {nameof(SecretSettingsKeys.BlobStoreConnectionString)}");

            _client = _account.CreateCloudBlobClient();
            _client.DefaultRequestOptions = new BlobRequestOptions
            {
                RetryPolicy = new ExponentialRetry(TimeSpan.FromSeconds(2), 5),
                MaximumExecutionTime = TimeSpan.FromMinutes(5),
            };

            _container = _client.GetContainerReference(ContainerName);
            AsyncHelper.RunSync(() => _container.CreateIfNotExistsAsync());

            _permissions = new BlobContainerPermissions { PublicAccess = BlobContainerPublicAccessType.Off };
            AsyncHelper.RunSync(() => _container.SetPermissionsAsync(_permissions));
        }

        public async Task<bool> DeleteBlobAsync(string path)
        {
            CloudBlockBlob blockBlob = _container.GetBlockBlobReference(path);
            return await blockBlob.DeleteIfExistsAsync();
        }

        public async Task<byte[]> GetBlobAsync(string path)
        {
            return await InternalGetBlobAsync(path);
        }

        public async Task<string> GetTextBlobAsync(string path)
        {
            var bytes = await InternalGetBlobAsync(path);
            return Encoding.UTF8.GetString(bytes);
        }

        public async Task<T> GetObjectBlobAsync<T>(string path)
        {
            var bytes = await InternalGetBlobAsync(path);

            using (MemoryStream ms = new MemoryStream(bytes))
            {
                IFormatter br = new BinaryFormatter();
                return (T)br.Deserialize(ms);
            }
        }

        async Task<byte[]> InternalGetBlobAsync(string path)
        {
            CloudBlockBlob blockBlob = _container.GetBlockBlobReference(path);
            var result = new MemoryStream();
            await blockBlob.DownloadToStreamAsync(result);
            return result.ToArray();
        }

        public async Task StoreBlobAsync(string path, byte[] bytes, bool overwriteExisting = true)
        {
           await InternalStoreBlobAsync(path, bytes, overwriteExisting);
        }

        public async Task StoreTextBlobAsync(string path, string text, bool overwriteExisting = true)
        {
            var bytes = Encoding.UTF8.GetBytes(text);
            await InternalStoreBlobAsync(path, bytes, overwriteExisting);
        }

        async Task InternalStoreBlobAsync(string path, byte[] bytes, bool overwriteExisting = true)
        {
            CloudBlockBlob blockBlob = _container.GetBlockBlobReference(path);
            if (!overwriteExisting && await blockBlob.ExistsAsync())
                throw new ArgumentException($"Path already exists: {path}");

            await blockBlob.UploadFromByteArrayAsync(bytes, 0, bytes.Length);
        }

        public async Task<bool> BlobExistsAsync(string path)
        {
            CloudBlockBlob blockBlob = _container.GetBlockBlobReference(path);
            return await blockBlob.ExistsAsync();
        }

        /// <summary>
        /// If root path is   :             myRoot/
        /// and full path is  : [container]/myRoot/123/abc/myFile.txt
        /// this will return  :                    123/abc/myFile.txt
        /// </summary>
        string GetSubfoldersAndFilenameFromFullPath(string rootPath, string fullPath)
        {
            int rootIdx = fullPath.IndexOf(rootPath);
            return fullPath.Substring(rootIdx + rootPath.Length);
        }

        public async Task<IEnumerable<string>> GetBlobsInFolder(string path, bool includeSubfolders = false, bool returnFullPath = false)
        {
            CloudBlobDirectory directory = _container.GetDirectoryReference(path);
            var blobs = directory.ListBlobs(useFlatBlobListing: includeSubfolders).Cast<CloudBlockBlob>().ToList();
            var names = blobs.Select(b => returnFullPath ? b.Name : GetSubfoldersAndFilenameFromFullPath(path, b.Name));
            return await Task.FromResult(names);
        }

        public async Task<IEnumerable<BlobDetailsDTO>> GetBlobDetailsInFolder(string path, bool includeSubfolders = false, bool returnFullPath = false)
        {
            CloudBlobDirectory directory = _container.GetDirectoryReference(path);
            var blobs = directory.ListBlobs(useFlatBlobListing: includeSubfolders).Cast<CloudBlockBlob>().ToList();
            var blobDetails = blobs.Select(b => new BlobDetailsDTO
            {
                FilePath = returnFullPath ? b.Name : GetSubfoldersAndFilenameFromFullPath(path, b.Name),
                LastModified = b.Properties.LastModified.HasValue ? b.Properties.LastModified.Value.DateTime : (DateTime?)null,
                CreatedOn = b.Properties.Created.HasValue ? b.Properties.Created.Value.DateTime : (DateTime?)null
            });
            return await Task.FromResult(blobDetails);
        }

        public IEnumerable<string> GetDebugInfo()
        {
            yield return GetType().Name;
        }
    }
}
