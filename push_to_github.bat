@echo off
title Push to GitHub (MultBook)
cd /d "%~dp0"
cd ..

echo [*] Проверка git-репозитория...
git rev-parse --is-inside-work-tree >nul 2>&1 || (
  echo [!] Эта папка не является Git-репозиторием!
  pause
  exit /b 1
)

echo [*] Настройка origin...
git remote -v

echo [*] Ветка main...
git branch -M main

echo [*] Проверка статуса...
git status

set /p MSG=Введите комментарий для коммита (Enter = авто): 
if "%MSG%"=="" (
  for /f %%T in ('powershell -NoP -C "(Get-Date).ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set MSG=auto: %%T
)

git add -A
git commit -m "%MSG%"
git push -u origin main

echo [OK] Изменения отправлены на GitHub.
pause
