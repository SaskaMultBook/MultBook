@echo off
echo Остановка старых процессов n8n...
taskkill /f /im n8n.exe 2>nul
taskkill /f /im node.exe 2>nul

echo Запуск n8n с туннелированием...
n8n start --tunnel

pause