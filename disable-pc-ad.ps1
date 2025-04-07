# Leer el archivo CSV con los nombres de los equipos
$Equipos = Import-Csv "C:\Users\kiara.arosemena\Desktop\EquiposInactivos2.csv"

foreach ($Equipo in $Equipos) {
    $NombreEquipo = $Equipo.Name
    
    # Obtener el objeto de la computadora en Active Directory
    $EquipoAD = Get-ADComputer -Filter {Name -eq $NombreEquipo} -Properties DistinguishedName

    # Verificar si se encontró el equipo
    if ($EquipoAD) {
        Write-Host "Equipo encontrado: $($EquipoAD.Name)"

        # Deshabilitar la cuenta usando el DistinguishedName
        Disable-ADAccount -Identity $EquipoAD.DistinguishedName
        Write-Host "Equipo deshabilitado: $($EquipoAD.Name)"
    } else {
        Write-Host "El equipo '$NombreEquipo' no se encontró en Active Directory."
    }
}
