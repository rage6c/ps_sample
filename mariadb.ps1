. $PSScriptRoot\library.ps1

$v = "10.6.4"
unzip "$PSScriptRoot\zip\mariadb-$v-winx64.zip" "$base"
link "$base\mariadb-$v-winx64" "$base\mariadb"
add_path "$base\mariadb\bin"

mysql_install_db

@"
mariadb is intalled, to start the server, run the following cmd

Run 'mysqld --standalone' or 'mysqld --console' to start the database
"@