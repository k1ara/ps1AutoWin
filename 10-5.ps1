# [Script para hacer backups de Contabilidad]

# Cambiar los colores de la consola
$Host.UI.RawUI.BackgroundColor = 'gray'
$Host.UI.RawUI.ForegroundColor = 'black'
Clear-Host  # Limpia la pantalla para aplicar los colores

# menu visible para usuario
function Show-Menu {
    Clear-Host
    Write-Host "=================================================================="
    Write-Host "=                                                                ="
    Write-Host "=        BIENVENIDO AL SISTEMA DE RESTAURACION DE CFE.           ="
    Write-Host "=                                                                ="
    Write-Host "= USTED TOMO ESTA OPCION PORQUE ESTA COMPLETAMENTE SEGURO DE     ="
    Write-Host "=                                                                ="
    Write-Host "=     RESTAURAR LA BASE DE DATOS A UN ESTADO ANTERIOR            ="
    Write-Host "=                        Version 1                               ="
    Write-Host "=              ESTA ACCION ES IRREVERSIBLE                       ="
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

        if ($date -match '^\d{2}-\d{2}-2025$') {
            $isValidDate = $true
        } else {
            Write-Host "ERROR: La fecha debe estar en el formato dd-mm-aaaa." -ForegroundColor Red
        }
    }
    # Ruta inicial del archivo de backup
    $path = "C:\$folder\CFE10002_${suffix}_$date.BAK"
    $pathRed = "\\svbi\$folder\CFE10002_${suffix}_$date.BAK"

    # Restaurar backup
    Write-Host "Espere mientras se está procesando la restauracion..." -ForegroundColor Green    
    #Invoke-Expression "sqlcmd -E -S 192.168.10.5 -Q "RESTORE DATABASE CFE10007 FROM DISK = '$path' WITH REPLACE, CHECKSUM""
    $sql = "RESTORE DATABASE CFE10008 FROM DISK = N'$path' WITH REPLACE, CHECKSUM"
    sqlcmd -E -S 192.168.10.5 -Q "$sql"
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
        1 { Get-Backup -folder 'TEST' -suffix 'ANTES_CIERRE' }
        2 { Get-Backup -folder 'TEST' -suffix 'DESPUES_CIERRE' }
        3 { Get-Backup -folder 'TEST' -suffix 'DESPUES_ABONO' }
        4 { Get-Backup -folder 'TEST' -suffix 'INTERMEDIO' }
        5 { Get-Backup -folder 'TEST' -suffix 'FIN_MES' }
        default {
            Write-Host ""
            Write-Host ">>> Opción inválida. Presione cualquier tecla para intentarlo de nuevo..." -ForegroundColor Red
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            . $MyInvocation.MyCommand.Path
                }
            }

        
