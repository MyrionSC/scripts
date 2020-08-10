@ECHO OFF

:: ------ Windows deploy script base

:: --- check if publish exists
if not exist "publish\TEST" echo "Publish folder <ROOT>publish\TEST does not exist. Did you forget to publish?" && exit()

:: --- borrows powershell functionality to mask input password. Output variable: %password%. (credits: unclemeat from SO)
:: powershell -Command $pword = read-host "Enter password for serviceuser SVCACC-LSC" -AsSecureString ; $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword) ; [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR) > .tmp.txt & set /p password=<.tmp.txt & del .tmp.txt

SET password=xxx :: Insert password here while testing

:: --- create current timestamp string (credits: mrt from SO)
set dt=%DATE:~6,4%_%DATE:~3,2%_%DATE:~0,2%__%TIME:~0,2%_%TIME:~3,2%_%TIME:~6,2%
set dt=%dt: =0%

:: --- create backup folder
echo "--- Creating backup dir: bak-%dt%..."
winrs -r:remote-computer -u:username -p:%password% "MKDIR PATH\bak-%dt%"

:: --- move stuff to backup folder
echo "--- moving stuff to backup dir..." 
robocopy source dest *.* /E /MOVE /XD Nlogs bak*

:: --- move publish to IIS folder
echo "--- Deploying new site..."
:: robocopy  src dest *.* /E



:: --- Test if running
:: curl



