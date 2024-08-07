@echo off

:: Recorrer todos los archivos .sql en el directorio de scripts
FOR %%I IN (*.BAK) DO (sqlcmd -E -S %server% -Q "RESTORE VERIFYONLY FROM DISK = '"C:\Backup\Test"\%%I.BAK' WITH CHECKSUM")


echo Ejecución de scripts completada.
endlocal
pause
