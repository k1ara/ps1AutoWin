::mapear la ruta del programa 7zip
set PATH=%PATH%;"C:\Program Files\7-Zip"

::descomprimir todos los archivos 7z en el directorio actual
FOR %%I IN (*.7z) DO ("C:\Program Files\7-Zip\7z.exe" x "%%I" -aoa)

pause