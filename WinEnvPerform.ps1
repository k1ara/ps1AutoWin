# Forzar la ejecución de PowerShell como Administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

# Cambiar a modo oscuro
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -Type DWORD -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -Type DWORD -Force

# Desactivar efectos de transparencia
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -Type DWORD -Force

# Desactivar efectos visuales
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2 -Type DWORD -Force

# Activar siempre las barras de desplazamiento
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility" -Name "DynamicScrollbars" -Value 0 -Type DWORD -Force

# Desactivar efectos de animación
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WindowMetrics" -Value 0 -Type DWORD -Force
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MinAnimate" -Value 0 -Type DWORD -Force

# Desactivar elementos específicos de la barra de tareas
# Desactivar Vista de Tareas
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0 -Type DWORD -Force

# Desactivar Widgets
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0 -Type DWORD -Force

# Desactivar Chat
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value 0 -Type DWORD -Force

# Cambiar el comportamiento de la barra de tareas a alineación hacia la izquierda
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0 -Type DWORD -Force

# Reiniciar el Explorador de Windows para aplicar los cambios
Stop-Process -Name explorer -Force
Start-Process explorer