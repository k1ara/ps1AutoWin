# [Script para hacer backups de Operaciones]

# Cambiar los colores de la consola
$Host.UI.RawUI.BackgroundColor = 'gray'
$Host.UI.RawUI.ForegroundColor = 'black'
Clear-Host  # Limpia la pantalla para aplicar los colores

function Show-Menu {
    Clear-Host
    Write-Host "=================================================================="
    Write-Host "=                                                                ="
    Write-Host "=           BIENVENIDO AL SISTEMA DE BACKUP DE CFE.              ="
    Write-Host "=                                                                ="
    Write-Host "= USTED TOMO ESTA OPCION PORQUE VA A REALIZAR EL CIERRE DEL DIA  ="
    Write-Host "=                                                                ="
    Write-Host "=     VERIFIQUE QUE TODOS LOS USUARIOS ESTEN FUERA DEL SISTEMA   ="
    Write-Host "=                        Version 3.1.2                           ="
    Write-Host "=================================================================="
    Write-Host
    Write-Host "Elija entre las siguientes opciones:"
    Write-Host "[1 = Aplicacion de Abonos]"
    Write-Host "[2 = Intermedio]"
    Write-Host "----------------------------------"
}

function Get-Backup {
    param (
        [string]$folder,
        [string]$suffix
    )

    $isValidDate = $false
    while (-not $isValidDate) {
        Write-Host "Introduzca la fecha de la base de datos en el siguiente formato dd-mm-aaaa:"
        Write-Host "----------------------------------"
        $date = Read-Host

        if ($date -match '^\d{2}-\d{2}-\d{4}$') {
            $isValidDate = $true
        } else {
            Write-Host "ERROR: La fecha debe estar en el formato dd-mm-aaaa." -ForegroundColor Red
        }
    }

    # Ruta inicial del archivo de backup
    $path = "C:\BACKUP\$folder\CFE10002_${suffix}_$date.BAK"
    $pathRed = "\\192.168.10.2\$folder\CFE10002_${suffix}_$date.BAK"

    # Verificación y solicitud de nuevo sufijo si el archivo ya existe
    $fileExist = Test-Path $pathRed
    while ($fileExist) {
        Write-Host "ERROR: El archivo '$path' ya existe." -ForegroundColor Red
        Write-Host "Ingrese un sufijo adicional para evitar la sobrescritura:"
        $newSuffix = Read-Host "Nuevo sufijo"
        $path = "C:\BACKUP\$folder\CFE10002_${suffix}_$date" + "_$newSuffix.BAK"
        
        # Actualizar la variable $fileExist después de construir la nueva ruta
        $fileExist = Test-Path $path
    }

    # Crear el backup
    Write-Host "Espere mientras se está procesando el backup..." -ForegroundColor Green
    Invoke-Expression "sqlcmd -E -S 192.168.10.2 -Q `"BACKUP DATABASE CFE10002 TO DISK = '$path' WITH CHECKSUM`""
    Write-Host
    Write-Host "********************************************"
    Write-Host "* El script ha finalizado."
    Write-Host "********************************************"
    Pause
    Exit
}

Show-Menu
    $choice = Read-Host

    switch ($choice) {
        1 { Get-Backup -folder 'BACKUP_DESPUES_APLICACION_ABONOS' -suffix 'DESPUES_ABONO' }
        2 { Get-Backup -folder 'BACKUP_INTERMEDIO' -suffix 'INTERMEDIO' }
        default {
           .$MyInvocation.MyCommand.Path 
        }
    }
    
