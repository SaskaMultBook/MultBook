@echo off
echo Пушим изменения в GitHub...
git add .
git commit -m "Final project update"
git push origin main
echo Готово.
pause