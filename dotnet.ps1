. $PSScriptRoot\library.ps1

$v = "5.0.401"
unzip "$PSScriptRoot\zip\dotnet-sdk-$v-win-x64.zip" "$base\dotnet-sdk-$v-win-x64"
link "$base\dotnet-sdk-$v-win-x64" "$base\dotnet-sdk"
add_path "$base\dotnet-sdk"

[System.Environment]::SetEnvironmentVariable("DOTNET_ROOT", "$base\dotnet-sdk", "User")

dotnet --version
