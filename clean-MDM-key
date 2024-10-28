# Verifica si la clave existe y elimínala
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\History\{7909AD9E-09EE-4247-BAB9-7029D5F0A278}"
if (Test-Path -Path $registryPath) {
    Remove-Item -Path $registryPath -Recurse -Force
    Write-Output "Clave MDM eliminada con éxito en $env:COMPUTERNAME"
} else {
    Write-Output "Clave MDM no encontrada en $env:COMPUTERNAME"
}
