@echo off
setlocal enabledelayedexpansion
title Backup MultBook

set "BACKUP_DIR=%~dp0MultBook_backup"
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

for /f %%T in ('powershell -NoP -C "(Get-Date).ToString(\"yyyy-MM-dd_HH-mm-ss\")"') do set DATETIME=%%T
set "ZIP_FILE=%BACKUP_DIR%\MultBook_!DATETIME!.zip"

echo [*] Создание временного архива...
tar -a -c -f "!ZIP_FILE!" *

echo [OK] Backup готов: "!ZIP_FILE!"
pause
