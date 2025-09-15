@echo off
title Backup MultBook
cd /d "%~dp0"
cd ..

set "SOURCE_DIR=%cd%"
set "BACKUP_DIR=%SOURCE_DIR%\MultBook_backup"

if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

for /f %%T in ('powershell -NoP -C "(Get-Date).ToString(\"yyyy-MM-dd_HH-mm-ss\")"') do set DATETIME=%%T
set "ZIP_FILE=%BACKUP_DIR%\MultBook_%DATETIME%.zip"

echo [*] Создаю резервную копию: "%ZIP_FILE%"
tar -a -c -f "%ZIP_FILE%" MultBook

echo [OK] Бэкап готов: "%ZIP_FILE%"
pause
