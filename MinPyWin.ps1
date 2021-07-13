# Python minimalist for windows
# Python version : 3.8.10
# Work on Powershell 5+

$url = ''
$system = ''

if ([Environment]::Is64BitOperatingSystem){
    $url = 'https://www.python.org/ftp/python/3.8.10/python-3.8.10-embed-amd64.zip'
    $system = 'x64'
}
else{
    $url = 'https://www.python.org/ftp/python/3.8.10/python-3.8.10-embed-win32.zip'
    $system = 'x32'
}

Write-Host ('[INFO] Setup Python 3.8.10 for {0} system' -f $system)

Write-Host "[INFO] Downloading Python 3.8 [Windows embeddable package version]"
Invoke-WebRequest -Uri $url -OutFile temp.zip 

Write-Host "[INFO] Extracting"
Expand-Archive temp.zip -DestinationPath .

Write-Host "[INFO] Setup Python environtment"
"`n./Lib/site-packages" | Out-File -FilePath .\python38._pth -Append -Encoding utf8

Write-Host "[INFO] Downloading pip"
Invoke-WebRequest -Uri 'https://bootstrap.pypa.io/get-pip.py' -OutFile './get-pip.py' 

Write-Host "[INFO] Installing pip"
./python get-pip.py --no-warn-script-location

Write-Host "[INFO] Removing unecessary files"
Remove-Item "./get-pip.py"
Remove-Item "./temp.zip"
Remove-Item Scripts -Recurse

Write-Host "[INFO] Done!"
Write-Host "`nPlease run your script with ./python [FILENAME] [ARGS]"
Write-Host "and using pip with ./python -m pip [PACKAGE] [ARGS]"
