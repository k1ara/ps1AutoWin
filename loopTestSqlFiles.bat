@echo off
setlocal

:: Configuración del servidor SQL Server
set "server=localhost"
set "username=sa"
set "database=CFE10002"
set "scripts_dir=sql_scripts"
set "output_dir=output"

:: Solicitar la contraseña sin mostrarla en la pantalla
set /p "password=Introduce la contraseña: " <nul

:: Crear el directorio de salida si no existe
if not exist "%output_dir%" mkdir "%output_dir%"

:: Recorrer todos los archivos .sql en el directorio de scripts
for %%f in ("%scripts_dir%\*.sql") do (
    echo Ejecutando %%f...
    sqlcmd -S %server% -U %username% -P %password% -d %database% -i "%%f" -o "%output_dir%\%%~nf_output.txt"
    if errorlevel 1 (
        echo Error al ejecutar %%f
    ) else (
        echo %%f ejecutado correctamente
    )
)

echo Ejecución de scripts completada.
endlocal
pause
