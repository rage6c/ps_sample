. $PSScriptRoot\library.ps1


$choice = Read-Host -Prompt @"
Which jdk to be installed? [8, 11, 15]
"@

switch ($choice) {
    "8" { $file = "jdk8"; break; }
    "11" { $file = "jdk11"; break; }
    "15" { $file = "jdk15"; break; }
    Default { Write-Output "Choose wisely"; exit 1 }
}

unzip $PSScriptRoot\zip\$file.zip $base
$javaHome = "$base\jdk"
link "$base\$file" $javaHome
add_path "$base\jdk\bin"
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHome, "User")

if ($choice -eq "8") {
    # keytool.exe -import -noprompt -trustcacerts -alias aaa -file $PSScriptRoot\certs\aaa.crt -keystore "$base\jdk\jre\lib\security\cacerts" -storepass changeit
}
else {
    # keytool.exe -import -noprompt -trustcacerts -alias aaa -file $PSScriptRoot\certs\aaa.crt -storepass changeit
}