@echo off
setlocal

:: Configuración del servidor SQL Server SVBI
set "server=localhost"
set "username=sa"
set "database=CFE10002"
set "scripts_dir=C:\TEST"
set "output_dir=output"

:: Solicitar la contraseña sin mostrarla en la pantalla
set /p "password=Introduce la contraseña: " <nul

:: Crear el directorio de salida si no existe
if not exist "%output_dir%" mkdir "%output_dir%"

:: Recorrer todos los archivos .sql en el directorio de scripts
FOR %%I IN (*.BAK) DO (sqlcmd -E -S %server% -Q "RESTORE VERIFYONLY FROM DISK = '"C:\Backup\Test"\%%I.BAK' WITH CHECKSUM" -o "%output_dir%\%%~nf_output.txt")


echo Ejecución de scripts completada.
endlocal
pause
