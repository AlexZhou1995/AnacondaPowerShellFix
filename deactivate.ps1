[CmdletBinding()]
Param(
)

cmd /c "deactivate.bat $Env & set" | % {
    if ($_ -match '=') {
        $key, $value = $_.Split('=')
        [Environment]::SetEnvironmentVariable($key, $value)
    }
}