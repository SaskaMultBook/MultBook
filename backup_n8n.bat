@echo on
@echo off
chcp 65001 >nul

set TIMESTAMP=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
set TIMESTAMP=%TIMESTAMP: =0%

:: Папка для сохранения бэкапов (убрал кириллицу!)
set BACKUP_DIR=C:\muLbook\backups

:: Создаём папку, если её нет
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

:: Запуск n8n через полный путь
call "C:\Users\Notarius\AppData\Roaming\npm\n8n.cmd" export:workflow --all --output "%BACKUP_DIR%\workflows_%TIMESTAMP
echo.
echo Нажмите любую клавишу для выхода...
pause >nul

