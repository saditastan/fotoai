@echo off
chcp 65001 >nul
cls

echo =============================================
echo   FotoAI Durduruluyor...
echo =============================================
echo.

docker-compose down

echo.
echo Sistem durduruldu!
echo.
pause
