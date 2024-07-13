# To install: 'Install-Module -Name QRCodeGenerator -scope CurrentUser'
# Documentation (run in powershell after import): Get-Help New-PSOneQRCodeURI -ShowWindow

$param1=$args[0]
Import-Module QRCodeGenerator
New-PSOneQRCodeURI -URI $param1 -Width 50 -Show

