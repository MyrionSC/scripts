// Import insomnia request object to Insomnia SentryExtension workspace
//   Just for windows right now

const fs = require("fs");
const child = require('child_process').spawn('powershell', ['-command', '"Get-Clipboard"'], {shell: true});
child.stdout.setEncoding('utf8');
child.stdout.on('data', function(data) {
    let clipboardData
    let insomniaRequestObj
    try {
        clipboardData = data.toString();
        insomniaRequestObj = JSON.parse(clipboardData)
    } catch (e) {
        console.log("clipboard should have been insomnia request object, was:", clipboardData)
        return
    }

    const insomniaDataDir = `${process.env.HOMEPATH}\\AppData\\Roaming\\Insomnia`
    const workSpaceFilePath = `${insomniaDataDir}\\insomnia.Workspace.db`

    const workspaceFileStr = fs.readFileSync(workSpaceFilePath, 'utf8');

    const workSpaceList = workspaceFileStr.split("\n").filter(s => s).map(s => JSON.parse(s))
    const sentryWorkSpace = workSpaceList.find(w => w.name === "SentryExtension")
    if (!sentryWorkSpace) throw Error(`No workspace with name 'SentryExtension' in file ${workSpaceFilePath}. Please create it in Insomnia.`)

    insomniaRequestObj.parentId = sentryWorkSpace._id

    const requestsFilePath = `${insomniaDataDir}\\insomnia.Request.db`

    fs.appendFileSync(requestsFilePath, JSON.stringify(insomniaRequestObj))

    console.log(`appended request '${insomniaRequestObj.method} ${insomniaRequestObj.url}' to ${requestsFilePath}`)
    console.log("Restart Insomnia to see it")
});



