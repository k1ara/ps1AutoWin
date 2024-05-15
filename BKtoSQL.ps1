# [Script para hacer backups de Contabilidad]

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
    Write-Host "[1 = Antes de Cierre]"
    Write-Host "[2 = Despues de Cierre]"
    Write-Host "[3 = Aplicacion de Abonos]"
    Write-Host "[4 = Intermedio]"
    Write-Host "[5 = Fin de Mes]"
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

    $path = "C:\BACKUP\$folder\CFE10002_${suffix}_$date.BAK"
    Write-Host "Espere mientras se esta procesando..." -ForegroundColor Green
    Invoke-Expression "sqlcmd -E -S 192.168.10.2 -Q `"BACKUP DATABASE CFE10002 TO DISK = '$path' WITH CHECKSUM`""
    Write-Host
    Write-Host "********************************************"
    Write-Host "* El script ha finalizado."
    Write-Host "********************************************"
    Pause
    Exit
}

$validChoice = $false

while (-not $validChoice) {
    Clear-Host
    Show-Menu

    $choice = Read-Host

    switch ($choice) {
        1 {
            $validChoice = $true
            Get-Backup -folder 'BACKUP_ANTES_CIERRE' -suffix 'ANTES_CIERRE'
        }
        2 {
            $validChoice = $true
            Get-Backup -folder 'BACKUP_DESPUES_CIERRE' -suffix 'DESPUES_CIERRE'
        }
        3 {
            $validChoice = $true
            Get-Backup -folder 'BACKUP_DESPUES_APLICACION_ABONOS' -suffix 'DESPUES_ABONO'
        }
        4 {
            $validChoice = $true
            Get-Backup -folder 'BACKUP_INTERMEDIO' -suffix 'INTERMEDIO'
        }
        5 {
            $validChoice = $true
            Get-Backup -folder 'BACKUP_FIN_MES' -suffix 'FIN_MES'
        }
        default {
            Write-Host "----------------------------------"
            Write-Host "ERROR, elija entre las siguientes opciones:"
            Pause
        }
    }
}

Show-Menu
    $choice = Read-Host

    switch ($choice) {
        1 { Get-Backup -folder 'BACKUP_ANTES_CIERRE' -suffix 'ANTES_CIERRE' }
        2 { Get-Backup -folder 'BACKUP_DESPUES_CIERRE' -suffix 'DESPUES_CIERRE' }
        3 { Get-Backup -folder 'BACKUP_DESPUES_APLICACION_ABONOS' -suffix 'DESPUES_ABONO' }
        4 { Get-Backup -folder 'BACKUP_INTERMEDIO' -suffix 'INTERMEDIO' }
        5 { Get-Backup -folder 'BACKUP_FIN_MES' -suffix 'FIN_MES' }
        default {
           .$MyInvocation.MyCommand.Path 
        }
    }
