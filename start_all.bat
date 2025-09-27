@echo off
title Запуск Ollama и n8n

echo === Запуск Ollama ===
start cmd /k "ollama serve"

timeout /t 5 >nul

echo === Запуск n8n ===
start cmd /k "n8n"

echo.
echo ✅ Ollama и n8n запущены!
echo Ollama: http://127.0.0.1:11434
echo n8n:    http://127.0.0.1:5678

pause
