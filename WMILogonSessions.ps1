# replace this with a valid hostname
$computerName = "MY HOST NAME HERE"
# collect all sessions using WMI
$loggedOnUsers = Get-WmiObject -Class Win32_LoggedOnUser -ComputerName $computerName
# empty arraylist
$logonSessions = New-Object System.Collections.ArrayList
# parse each entry
foreach ($user in $loggedOnUsers) {
    $antecedentData = $user.Antecedent.Split('"')
    $userDomain = $antecedentData[1]
    $userName = $antecedentData[3]
    $userInstance = $user.Dependent.Split('"')[1]
    $session = Get-WmiObject -Class Win32_LogonSession | Where-Object { $_.LogonId -eq $userInstance }
    $logonTime = [Management.ManagementDateTimeConverter]::ToDateTime($session.StartTime)
    # add the logon session object to the arraylist
    $index = $logonSessions.Add([PSCustomObject]@{
        User       = "$userDomain\$userName"
        LogonTime  = $logonTime
        SessionID  = $userInstance
    })
    Write-Progress -PercentComplete (($index+1)/$loggedOnUsers.Count*100) -Status "Parsing sessions" -Activity "Current session: $userInstance"
}

# show collected sessions with ordering
$logonSessions | Sort-Object -Property LogonTime
