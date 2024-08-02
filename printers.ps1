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

# Definir el menú para instalar impresora
function Show_Menu2 {
    Clear-Host
    Write-Host "1. Opción 1: Canon_MESADC1" -ForegroundColor Green
    Write-Host "2. Opción 2: Canon_COLOR" -ForegroundColor Green
    Write-Host "3. Opción 3: Canon_1730" -ForegroundColor Green
    Write-Host "4. Salir" -ForegroundColor Red
}

# Función para mostrar impresoras instaladas
function show_printers {
    Get-Printer | Format-Table -AutoSize
}

# Función para listar archivos
function Instalar_Impresoras {
    Show_Menu2
    Run_Menu2
# Función principal para manejar la selección del menú
function Run_Menu2 {
    do {
        
        $opcionM2 = Read-Host "Seleccione una opción (1-3)"
        
        switch ($opcionM2) {
            '1' { Canon_MESADC1}
            '2' { Canon_COLOR }
            '3' { Write-Host "Saliendo..."; exit }
            default { Write-Host "Opción no válida. Intente de nuevo." -ForegroundColor Red }
        }
        
        Read-Host "Presione Enter para continuar..."
        
    } while ($opcion -ne '3')
}
function Canon_MESADC1 {
Add-Printer -Name "Canon_MesaDC" -PortName "192.168.12.6" -DriverName "Canon Generic Plus UFR II" -DeviceURL "\\SR-WIN-NAS\Canon_MESADC1"
    }
function Canon_COLOR {
    Add-Printer -Name "Canon_Color" -PortName "192.168.12.7" -DriverName "Canon iR C1325/1335 UFR II" -DeviceURL "\\SR-WIN-NAS\Canon_COLOR"
    }

}

# Función para mostrar IP local
function Desinstalar_Impresoras {
    $opcionD = Read-Host "Indique cual impresora desea desinstalar:"
    
    Remove-Printer -Name "$opcionD"
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