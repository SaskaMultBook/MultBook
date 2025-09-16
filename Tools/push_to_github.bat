@echo off
setlocal enableextensions enabledelayedexpansion
chcp 65001 >nul
title Push to GitHub (MultBook)

REM --- Переходим в корень MultBook (скрипт лежит в Tools) ---
cd /d "%~dp0.."

echo === Проверка git-репозитория ===
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
  echo Эта папка не является git-репозиторием.
  echo Откройте скрипт из папки MultBook\\Tools, где уже инициализирован репозиторий.
  echo (или выполните "git init -b main" вручную один раз)
  pause
  exit /b 1
)

echo === Проверка origin ===
git remote get-url origin >nul 2>&1
if errorlevel 1 (
  echo ВНИМАНИЕ: origin не настроен. Если у вас уже есть репозиторий на GitHub,
  echo добавьте его один раз:
  echo   git remote add origin https://github.com/<youruser>/<yourrepo>.git
  echo и запустите скрипт снова.
  pause
  exit /b 1
)

echo === Проверка ветки main ===
for /f "delims=" %%B in ('git rev-parse --abbrev-ref HEAD') do set CURRBR=%%B
if /I not "!CURRBR!"=="main" (
  echo Текущая ветка: !CURRBR!  (будет пуш на origin/main)
)

echo === Статус ===
git status --short

REM Считаем количество строк в статусе
for /f %%C in ('git status --porcelain ^| find /c /v ""') do set COUNT=%%C

if "!COUNT!"=="0" (
  echo Изменений нет — создаю push без коммита...
) else (
  set /p MSG=Комментарий к коммиту (Enter — авто): 
  if "!MSG!"=="" (
    for /f %%T in ('powershell -NoP -C "(Get-Date).ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set MSG=auto: %%T
  )
  git add -A
  if errorlevel 1 goto :err
  git commit -m "!MSG!"
  if errorlevel 1 goto :err
)

echo === Push ===
git push -u origin HEAD:main
if errorlevel 1 goto :err

echo === Готово. Нажмите любую клавишу ===
pause
exit /b 0

:err
echo.
echo !!! Произошла ошибка. Проверьте сообщения выше.
pause
exit /b 1