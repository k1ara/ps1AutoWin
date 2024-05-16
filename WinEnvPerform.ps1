# Cambiar a modo oscuro
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -PropertyType DWORD -Force

# Desactivar efectos de transparencia
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -PropertyType DWORD -Force

# Desactivar efectos visuales
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name VisualFXSetting -Value 2

# Activar siempre las barras de desplazamiento
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value 0

# Desactivar efectos de animación
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value 0x10

# Quitar widgets de la barra de tareas menos Copilot
$widgetsToRemove = @("Weather","News","Microsoft.ToDo","Photos","Bing","Microsoft Store","Spotify","Microsoft.Office.OneNote_8wekyb3d8bbwe!microsoft.unity.NotebookPlugin","Microsoft.Microsoft3DViewer_8wekyb3d8bbwe!App")
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"

foreach ($widget in $widgetsToRemove) {
    New-ItemProperty -Path $regPath -Name $widget -Value 0 -PropertyType DWORD -Force
}

# Cambiar el comportamiento de la barra de tareas a alineación hacia la izquierda
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0

# Reiniciar el Explorador de Windows para aplicar los cambios
Stop-Process -Name explorer -Force
