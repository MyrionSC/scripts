SET serverName=s110396
SET serviceAccount=%TESTSERVER_SERVICEACCOUNT%
SET devPathName=%TESTSERVER_DEV_PATH_NAME%
SET password=%TESTSERVER_PASSWORD%

@ECHO ON
echo === Starting publish...
dotnet publish WebApi.Api -c Testkbo -o ./publish/api
dotnet publish WebApp.Web -c testmartin -o ./publish/web

@REM TODO: make customisable
@REM or figure out how to set env on server
echo === Copying test configuration...
copy /Y "WebApi.Api\appsettings.Development.json" "publish\api\appsettings.json"
copy /Y "WebApp.Web\appsettings.testmartin.json" "publish\web\appsettings.json"

@REM echo === Starting zip...
powershell Compress-Archive -Path ./publish/api/* -DestinationPath ./publish/api.zip -Force
powershell Compress-Archive -Path ./publish/web/* -DestinationPath ./publish/web.zip -Force

@ECHO OFF
@REM Man kan nok lave powershell certificate hvor den tager fra systembrugeren men mit powershell game er ikke så godt
echo === Mounting remote drive on D...
powershell -Command "$password = ConvertTo-SecureString -String %password% -AsPlainText -Force; New-PSDrive -Name 'D' -PSProvider FileSystem -Root '\\%serverName%\D$' -Credential (New-Object System.Management.Automation.PSCredential('AAK\%serviceAccount%', $password))"

echo === copying zip files to server...
copy "publish\api.zip" "\\%serverName%\D$\inetpub\%devPathName%\api.zip"
copy "publish\web.zip" "\\%serverName%\D$\inetpub\%devPathName%\web.zip"

SET apiPath=D:\inetpub\%devPathName%
echo === Unzip files in %apiPath%
powershell -Command "$password = ConvertTo-SecureString -String %password% -AsPlainText -Force; $credentials = New-Object System.Management.Automation.PSCredential('AAK\%serviceAccount%', $password); Invoke-Command -ComputerName %serverName% -Credential $credentials -ScriptBlock { param($apiPath) Expand-Archive -Path "$apiPath\api.zip" -DestinationPath $apiPath -Force }" -ArgumentList '%apiPath%'

@REM hvis det fejler her på grund af rettigheder, prøv igen.
SET webPath=D:\inetpub\%devPathName%
echo === Unzip files in %webPath%
powershell -Command "$password = ConvertTo-SecureString -String %password% -AsPlainText -Force; $credentials = New-Object System.Management.Automation.PSCredential('AAK\%serviceAccount%', $password); Invoke-Command -ComputerName %serverName% -Credential $credentials -ScriptBlock { param($webPath) Expand-Archive -Path "$webPath\web.zip" -DestinationPath $webPath -Force }" -ArgumentList '%webPath%'
@ECHO ON

echo === Unmounting remote drive...
net use "\\%serverName%\D$" /delete

