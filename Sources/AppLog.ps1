#================================================================================
Function WriteAppLog {
    param(
        $LogLevel,
        [String]$LogString

    )        
    if ($LogLevel -ge $AppLogPreference) {
        Switch ($LogLevel) {
            0 { $LogLevelString = 'Trace' }
            1 { $LogLevelString = 'Debug' }
            2 { $LogLevelString = 'Info' }
            3 { $LogLevelString = 'Warn' }
            4 { $LogLevelString = 'Error' }
            5 { $LogLevelString = 'Fatal' }
            Default { $LogLevel = 'Unknown' }
        }
        $Now = Get-Date
        $Log = $Now.ToString("yyyy/MM/dd HH:mm:ss.fff") + " : " + $LogLevelString + " : "
        $Log += $LogString
        Write-Output $Log | Out-File -FilePath ([PathDefiner]::AppLogPath) -Encoding Default -Append
    }
}
#================================================================================