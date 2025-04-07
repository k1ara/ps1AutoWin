# Definir la carpeta donde están los archivos
$directorio = "C:\Users\kiara.arosemena\Desktop\ps1AutoWin"  # Cambia esto por la ruta de tu carpeta
$archivos = Get-ChildItem -Path $directorio -File

# Verificar si hay archivos en la carpeta
if ($archivos.Count -eq 0) {
    Write-Host "No hay archivos en la carpeta."
    exit
}

# Mostrar la lista de archivos con un índice numérico
Write-Host "Seleccione un archivo escribiendo el número correspondiente:`n"
for ($i = 0; $i -lt $archivos.Count; $i++) {
    Write-Host "$($i + 1): $($archivos[$i].Name)"
}

# Pedir al usuario que seleccione un número
do {
    $opcion = Read-Host "`nIngrese el número del archivo"
    $valido = $opcion -match "^\d+$" -and [int]$opcion -ge 1 -and [int]$opcion -le $archivos.Count
    if (-not $valido) { Write-Host "Opción no válida. Intente de nuevo." -ForegroundColor Red }
} while (-not $valido)

# Obtener el archivo seleccionado
$archivoSeleccionado = $archivos[[int]$opcion - 1].FullName
Write-Host "`nArchivo seleccionado: $archivoSeleccionado"

# Aquí puedes usar $archivoSeleccionado en tu script

