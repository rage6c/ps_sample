$base = ($HOME) + '\win'

function init {
    if (!(Test-Path $base)) {
        Write-Host 'Creating local floder'
        New-Item -Path $base -ItemType Directory
        New-Item -Path $base\bin -ItemType Directory
        add_path
    }
}

function reload_path() {
    $env:Path = (
        [System.Environment]::GetEnvironmentVariable("Path", "Machine"),
        [System.Environment]::GetEnvironmentVariable("Path", "User")
    ) -match '.' -join ';'
    
}

function add_path($p) {
    $user_path = [System.Environment]::GetEnvironmentVariable("Path", "User")
    if (!$user_path) {
        $user_path = ""
    }
    
    if ($user_path.Contains($p)) {
        # "$p is already in the path"
    }
    else {
        [System.Environment]::SetEnvironmentVariable("PATH", ($user_path + ";" + $p), "User")
    }
    
    reload_path
}

function link($src, $target) {
    if (Test-Path $target) {
        Remove-Item $target -Force -Confirm:$false -Recurse
    }

    New-Item -Type Junction -Value $src -Path $target
}

function unzip($src, $target) {
    $t = "-o" + $target + ""
    7z.exe x $src $t -aoa    
}

init
