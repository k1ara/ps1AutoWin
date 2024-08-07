@echo off

set "server=localhost"

:: Recorrer todos los archivos .bak en el directorio de scripts
FOR %%I IN (*.BAK) DO (
    sqlcmd -E -S %server% -Q "RESTORE VERIFYONLY FROM DISK = 'C:\Test\%%I' WITH CHECKSUM"
)
pause
