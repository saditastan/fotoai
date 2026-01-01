@echo off
chcp 65001 >nul
cls

echo =============================================
echo   FotoAI Baslatiliyor...
echo =============================================
echo.

docker-compose up -d

echo.
echo Sistem baslatildi!
echo.
echo Tarayicinizda acin: http://localhost:3000
echo.
timeout /t 2 /nobreak >nul
start http://localhost:3000
pause
