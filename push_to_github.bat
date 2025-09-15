@echo off
setlocal enabledelayedexpansion
title Push to GitHub (MultBook)
cd /d "%~dp0"

echo === Проверка, что это git-репозиторий ===
git rev-parse --is-inside-work-tree >nul 2>&1 || (
  echo Эта папка не является Git-репозиторием.
  pause
  exit /b 1
)

set "REPO_URL=https://github.com/SaskaMultBook/MultBook.git"

echo === Настраиваю origin ===
git remote get-url origin >nul 2>&1
if errorlevel 1 (
  git remote add origin "%REPO_URL%"
) else (
  for /f "delims=" %%U in ('git remote get-url origin') do set CURR_URL=%%U
  if /I not "!CURR_URL!"=="%REPO_URL%" (
    git remote set-url origin "%REPO_URL%"
  )
)

echo === Ветка main ===
git rev-parse --verify main >nul 2>&1 || git branch -M main

echo === Статус ===
git status

set /p MSG=Введите комментарий к коммиту (Enter — авто): 
if "!MSG!"=="" (
  for /f %%T in ('powershell -NoP -C "(Get-Date).ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set MSG=auto: %%T
)

git add -A
git commit -m "!MSG!"
git push -u origin main

echo === Завершено ===
pause
cmd /k
