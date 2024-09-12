::mapear la ruta del programa 7zip
set PATH=%PATH%;"C:\Program Files\7-Zip"

::Opciones de 7zip para descompresión
::-aos: No sobrescribe archivos existentes (los salta).
::-aou: Renombra archivos extraídos si ya existen.
::-aot: Sobrescribe solo si los archivos del archivo comprimido son más recientes.
::-aoa: Sobrescribe todos los archivos sin preguntar.

::descomprimir todos los archivos 7z en el directorio actual
FOR %%I IN (*.7z) DO ("C:\Program Files\7-Zip\7z.exe" x "%%I" -aoa)

pause