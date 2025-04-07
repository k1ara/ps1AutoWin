# Configuración de las carpetas de backups
$carpetas = @(
    "\\192.168.10.2\backup_antes_cierre",
    "\\192.168.10.2\backup_despues_cierre",
    "\\192.168.10.2\backup_intermedio",
    "\\192.168.10.2\backup_despues_aplicacion_abonos",
    "\\192.168.10.2\backup_fin_mes"
)

# Mostrar las opciones de carpetas
Write-Host "Seleccione la carpeta de respaldo:"
for ($i = 0; $i -lt $carpetas.Count; $i++) {
    Write-Host "$($i + 1): $($carpetas[$i])"
}

# Pedir la selección del usuario
do {
    $opcionCarpeta = Read-Host "`nIngrese el número de la carpeta"
    $valido = $opcionCarpeta -match "^\d+$" -and [int]$opcionCarpeta -ge 1 -and [int]$opcionCarpeta -le $carpetas.Count
    if (-not $valido) { Write-Host "Opción no válida. Intente de nuevo." -ForegroundColor Red }
} while (-not $valido)

# Carpeta seleccionada
$carpetaSeleccionada = $carpetas[[int]$opcionCarpeta - 1]
Write-Host "`nCarpeta seleccionada: $carpetaSeleccionada"

# Obtener los archivos .bak en la carpeta seleccionada
$archivos = Get-ChildItem -Path $carpetaSeleccionada -Filter "*.bak" -File

# Verificar si hay backups
if ($archivos.Count -eq 0) {
    Write-Host "No hay archivos .bak en esta carpeta." -ForegroundColor Red
    exit
}

# Mostrar los archivos disponibles
Write-Host "`nSeleccione el archivo de respaldo:"
for ($i = 0; $i -lt $archivos.Count; $i++) {
    Write-Host "$($i + 1): $($archivos[$i].Name)"
}

# Pedir selección del archivo
do {
    $opcionArchivo = Read-Host "`nIngrese el número del archivo"
    $valido = $opcionArchivo -match "^\d+$" -and [int]$opcionArchivo -ge 1 -and [int]$opcionArchivo -le $archivos.Count
    if (-not $valido) { Write-Host "Opción no válida. Intente de nuevo." -ForegroundColor Red }
} while (-not $valido)

# Archivo seleccionado
$archivoSeleccionado = $archivos[[int]$opcionArchivo - 1].FullName
Write-Host "`nArchivo seleccionado: $archivoSeleccionado"

# Definir nombre de la base de datos (puedes cambiar esto)
$databaseName = "CFE10002"

# Comando para restaurar la base de datos usando sqlcmd
$restoreCommand = @"
RESTORE DATABASE [$databaseName] FROM DISK = N'$archivoSeleccionado' 
WITH REPLACE, MOVE '$databaseName' TO 'C:\SQLData\$databaseName.mdf', 
MOVE '$databaseName\_log' TO 'C:\SQLData\$databaseName.ldf'
"@

# Ejecutar el comando en SQL Server
Write-Host "`nRestaurando la base de datos..."
$sqlcmd = "sqlcmd -S 192.168.10.2 -d CFE10002 -Q `"$restoreCommand`""
Invoke-Expression $sqlcmd

Write-Host "`nProceso finalizado."
