[CmdletBinding()]
Param(
    [Parameter(Position = 1)]
    [string] $Env 
)

function getcondaenv {
    conda info -e | ? {$_ -notmatch "^#" } | % { 
        $envs = ($_ -split "\s+")
#        Write-Host ("{0}, {1}" -f $envs.Length, $_)

        if ($envs.Length -gt 2) {
            [PSCustomObject]@{Name = $envs[0]; Used = $envs[1]; Path = $envs[2]}
        }
        elseif ($envs.Length -eq 2) {
            [PSCustomObject]@{Name = $envs[0]; Used = ""; Path = $envs[1]}
        }
    }
}

if($Env){
    cmd /c "activate.bat $Env & set" | % {
        if ($_ -match '=') {
            $key, $value = $_.Split('=')
            [Environment]::SetEnvironmentVariable($key, $value)
        }
    }
}
else {
    getcondaenv 
}