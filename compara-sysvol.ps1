# === CONFIGURA ESTAS VARIABLES ===
$dc1 = "\\Dasd\sysvol\cfe.local\Policies"
$dc2 = "\\Dasd01\sysvol\cfe.local\Policies"

# === OBTIENE TODOS LOS ARCHIVOS (con rutas relativas) ===
function Get-RelativeFileList($basePath) {
    Get-ChildItem -Path $basePath -Recurse -File | ForEach-Object {
        $_.FullName.Replace($basePath, "")
    }
}

Write-Host "`nObteniendo archivos desde $dc1..." -ForegroundColor Cyan
$filesDC1 = Get-RelativeFileList $dc1

Write-Host "Obteniendo archivos desde $dc2..." -ForegroundColor Cyan
$filesDC2 = Get-RelativeFileList $dc2

# === COMPARA ARCHIVOS ===
$missingInDC2 = $filesDC1 | Where-Object { $_ -notin $filesDC2 }
$extraInDC2   = $filesDC2 | Where-Object { $_ -notin $filesDC1 }

# === RESULTADOS ===
Write-Host "`n--- Archivos que FALTAN en DC2 ---" -ForegroundColor Yellow
if ($missingInDC2) {
    $missingInDC2 | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "Ninguno 🎉"
}

Write-Host "`n--- Archivos EXTRA en DC2 (que no están en DC1) ---" -ForegroundColor Magenta
if ($extraInDC2) {
    $extraInDC2 | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "Ninguno"
}