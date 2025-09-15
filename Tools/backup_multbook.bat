@echo off
setlocal
title Backup MultBook

cd /d "%~dp0\.."

set "BACKUP_DIR=%cd%\MultBook_backup"
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

for /f %%T in ('powershell -NoP -C "(Get-Date).ToString(\"yyyy-MM-dd_HH-mm-ss\")"') do set DATETIME=%%T
set "ZIP_FILE=%BACKUP_DIR%\MultBook_%DATETIME%.zip"

echo [*] Creating backup: "%ZIP_FILE%"
powershell -NoP -C "Compress-Archive -Path * -DestinationPath '%ZIP_FILE%' -Force"

echo [OK] Backup created: "%ZIP_FILE%"
pause
