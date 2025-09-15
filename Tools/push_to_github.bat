@echo off
setlocal enabledelayedexpansion
title Push to GitHub (MultBook)
cd /d "%~dp0\.."

echo === Проверка, что это Git-репозиторий ===
git rev-parse --is-inside-work-tree >nul 2>&1 || (
  echo Эта папка не является Git-репозиторием.
  pause
  exit /b 1
)

echo === Настройка origin ===
set "REPO_URL=https://github.com/SaskaMultBook/MultBook.git"
git remote get-url origin >nul 2>&1
if errorlevel 1 (
  git remote add origin "%REPO_URL%"
) else (
  git remote set-url origin "%REPO_URL%"
)

echo === Проверка ветки main ===
git rev-parse --verify main >nul 2>&1 || git branch -M main

echo === Проверка статуса ===
git status
git add -A

set /p MSG=Введите комментарий к коммиту (Enter — авто): 
if "!MSG!"=="" (
  for /f %%T in ('powershell -NoP -C "(Get-Date).ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set MSG=auto: %%T
)

git commit -m "!MSG!"
git push -u origin main

echo === Готово. Проверь изменения на GitHub. ===
pause
