# Definir el menú
function Show_Menu {
    Clear-Host
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "         Menú Principal             " -ForegroundColor Cyan
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "1. Opción 1: Mostrar impresoras instaladas" -ForegroundColor Green
    Write-Host "2. Opción 2: Instalar impresoras en red manualmente" -ForegroundColor Green
    Write-Host "3. Opción 3: Desinstalar impresora" -ForegroundColor Green
    Write-Host "4. Salir" -ForegroundColor Red
    Write-Host "====================================" -ForegroundColor Cyan
}

# Función para mostrar impresoras instaladas
function show_printers {
    Get-Printer | Format-Table -AutoSize
}

# Función para listar archivos
function Instalar_Impresoras {
    Write-Host "Archivos en el directorio actual:" -ForegroundColor Yellow
    Get-ChildItem
}

# Función para mostrar IP local
function Desinstalar_Impresoras {
    $ip = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.Address -ne '127.0.0.1' }).IPAddress
    Write-Host "Dirección IP local: $ip" -ForegroundColor Yellow
}

# Función principal para manejar la selección del menú
function Ejecutar_Menu {
    do {
        Show_Menu
        $opcion = Read-Host "Seleccione una opción (1-4)"
        
        switch ($opcion) {
            '1' { show_printers}
            '2' { Instalar_Impresoras }
            '3' { Desinstalar_Impresoras}
            '4' { Write-Host "Saliendo..."; exit }
            default { Write-Host "Opción no válida. Intente de nuevo." -ForegroundColor Red }
        }
        
        Read-Host "Presione Enter para continuar..."
        
    } while ($opcion -ne '4')
}

# Ejecutar el menú
Ejecutar_Menu