@echo off
setlocal enableextensions enabledelayedexpansion
chcp 65001 >nul
title Backup MultBook

REM --- Переходим в корень MultBook (скрипт лежит в Tools) ---
cd /d "%~dp0.."

REM Папка для бэкапов
set "BACKUP_DIR=%cd%\MultBook_backup"
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

REM Дата/время для имени файла
for /f %%T in ('powershell -NoP -C "(Get-Date).ToString(\"yyyy-MM-dd_HH-mm-ss\")"') do set DATETIME=%%T

set "TMPZIP=%TEMP%\MultBook_%DATETIME%.zip"
set "FINALZIP=%BACKUP_DIR%\MultBook_%DATETIME%.zip"

echo [*] Создаю архив во временной папке: "%TMPZIP%"
REM --- Сначала пробуем tar (обычно есть в Win10/11) ---
tar --version >nul 2>&1
if not errorlevel 1 (
  REM Исключаем саму папку бэкапов, .git и ZIP-файлы
  tar -a -c -f "%TMPZIP%" --exclude="MultBook_backup" --exclude=".git" --exclude="*.zip" *
  if errorlevel 1 goto :pwsh
) else (
  goto :pwsh
)

goto :movezip

:pwsh
echo [*] tar недоступен или дал ошибку — пробую PowerShell Compress-Archive...
powershell -NoProfile -Command ^
  "$items = Get-ChildItem -Force -LiteralPath . | Where-Object { $_.Name -ne 'MultBook_backup' -and $_.Name -ne '.git' -and $_.Name -ne 'MultBook_tools.zip' -and $_.Name -ne 'MultBook_tools_FIXED.zip' -and -not ($_.Name -like '*.zip') }; ^
   Compress-Archive -Path $items -DestinationPath '%TMPZIP%' -CompressionLevel Optimal -Force"

if errorlevel 1 (
  echo !!! Ошибка при создании архива.
  pause
  exit /b 1
)

:movezip
echo [*] Переношу архив в "%FINALZIP%"
move /y "%TMPZIP%" "%FINALZIP%" >nul
if errorlevel 1 (
  echo !!! Не удалось переместить архив.
  pause
  exit /b 1
)

echo [OK] Бэкап создан: "%FINALZIP%"
echo Нажмите любую клавишу для выхода...
pause
exit /b 0