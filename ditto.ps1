. $PSScriptRoot\library.ps1

Stop-Process -Name Ditto -ErrorAction Ignore

unzip "$PSScriptRoot\zip\DittoPortable_64bit_3_24_184_0.zip" "$base\DittoPortable_64bit_3_24_184_0"
link "$base\DittoPortable_64bit_3_24_184_0" "$base\ditto"

$wsh = New-Object -ComObject WScript.Shell
$shortcut = $wsh.CreateShortcut("$HOME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Ditto.lnk")
$shortcut.TargetPath = "$base\ditto\ditto.exe"
$shortcut.WorkingDirectory = "$base\ditto\"

$shortcut.Save()
