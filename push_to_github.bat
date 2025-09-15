@echo off
setlocal
title Push to GitHub (MultBook)
cd /d "%~dp0"

echo === Проверка репозитория ===
git rev-parse --is-inside-work-tree >nul 2>&1 || (
  echo Эта папка не является Git-репозиторием.
  pause
  exit /b 1
)

echo === Добавляем изменения ===
git add -A

echo === Коммит ===
set /p MSG=Комментарий к коммиту (Enter — автокомментарий): 
if "%MSG%"=="" (
  for /f %%T in ('powershell -NoP -C "(Get-Date).ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set MSG=auto: %%T
)

git diff --cached --quiet
if %errorlevel%==0 (
  echo Нет изменений для коммита.
) else (
  git commit -m "%MSG%"
)

echo === Отправка на GitHub ===
git push -u origin main

echo === Готово ===
pause

