Import-Module ActiveDirectory

Get-ADComputer -Filter * -Property Name, LastLogonTimestamp | ForEach-Object {
    $lastLogonDate = if ($_.LastLogonTimestamp) {
        [DateTime]::FromFileTime($_.LastLogonTimestamp)
    } else {
        $null
    }

    if ($lastLogonDate -lt (Get-Date).AddDays(-90)) {
        [PSCustomObject]@{
            Name           = $_.Name
            LastLogonDate  = $lastLogonDate
        }
    }
} | Export-Csv -Path "EquiposInactivos.csv" -NoTypeInformation

