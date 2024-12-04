Import-Module ActiveDirectory

Get-ADComputer -Filter * -Property Name, LastLogonTimestamp |
Where-Object {
    $_.LastLogonTimestamp -lt (Get-Date).AddDays(-90)
} | 
Select-Object Name, @{Name="LastLogonDate";Expression={[DateTime]::FromFileTime($_.LastLogonTimestamp)}}
