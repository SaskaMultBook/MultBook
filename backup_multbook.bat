@echo off
set TEMP_BACKUP=%TEMP%\multibook_backup.zip
echo Создание временного архива...
powershell -command "Compress-Archive -Path * -DestinationPath %TEMP_BACKUP% -Force"
echo Перенос архива...
move %TEMP_BACKUP% .\backup_multbook.zip
echo Бэкап создан: backup_multbook.zip
pause