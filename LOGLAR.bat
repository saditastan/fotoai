@echo off
chcp 65001 >nul
cls

echo =============================================
echo   FotoAI Hata Loglari
echo =============================================
echo.
echo Hatalari gormek icin bu pencere acik kalacak.
echo Kapatmak icin Ctrl+C basin.
echo.

docker-compose logs -f
