# Lista de equipos en el dominio
$computers = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

# Almacena las credenciales solo una vez
$credential = Get-Credential

# Listas para resultados
$eliminadas = @()
$noEliminadas = @()

# Contador para el progreso
$totalComputers = $computers.Count
$currentComputer = 0

# Ejecuta el comando en cada máquina con las credenciales almacenadas
foreach ($computer in $computers) {
    # Actualiza el contador y muestra el progreso
    $currentComputer++
    $percentComplete = ($currentComputer / $totalComputers) * 100
    Write-Progress -Activity "Eliminando claves en equipos" -Status "Procesando $computer" -PercentComplete $percentComplete

    $result = Invoke-Command -ComputerName $computer -ScriptBlock {
        param ($keyPath)
        if (Test-Path -Path $keyPath) {
            Remove-Item -Path $keyPath -Recurse -Force -ErrorAction SilentlyContinue
            # Verifica si se eliminó exitosamente
            if (-not (Test-Path -Path $keyPath)) {
                return "Eliminada"
            } else {
                return "No eliminada"
            }
        } else {
            return "No existía"
        }
    } -ArgumentList "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\History\{7909AD9E-09EE-4247-BAB9-7029D5F0A278}" -Credential $credential -ErrorAction SilentlyContinue

    # Clasifica el resultado
    if ($result -eq "Eliminada") {
        $eliminadas += $computer
    } else {
        $noEliminadas += $computer
    }
}

# Imprime los resultados
Write-Output "Máquinas donde la clave fue eliminada: $($eliminadas -join ', ')"
Write-Output "Máquinas donde la clave no se eliminó o no existía: $($noEliminadas -join ', ')"
