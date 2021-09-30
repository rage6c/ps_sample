. $PSScriptRoot\library.ps1


$v = "3.8.2"
$file = "apache-maven-${v}-bin.zip"

unzip $PSScriptRoot\zip\$file $base -Force
if (Test-Path $base\maven) {
    Remove-Item $base\maven -Force -Recurse
}

New-Item -Type Junction -Value $base\apache-maven-${v} -Path $base\maven

add_path "$base\maven\bin"

[System.Environment]::SetEnvironmentVariable("MAVEN_HOME", "$base\maven", "User")
[System.Environment]::SetEnvironmentVariable("MAVEN_OPTS", "-Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true -Dmaven.wagon.http.ssl.ignore.validity.dates=true", "User")

reload_path

if(!(Test-Path "~\.m2")){
    New-Item -Path "~\.m2" -ItemType Directory
}

Out-File -Encoding ascii -FilePath "~\.m2\settings.xml" -InputObject @"
<settings xmlns="http://maven.apache.org/SETTINGS/1.2.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.2.0 http://maven.apache.org/xsd/settings-1.2.0.xsd">
    <mirrors>
        <mirror>
            <mirrorOf/>
            <name/>
            <url/>
            <layout/>
            <mirrorOfLayouts/>
            <blocked/>
            <id/>
        </mirror>
    </mirrors>
</settings>
"@

mvn -version