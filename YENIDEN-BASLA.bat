@echo off
chcp 65001 >nul
cls

echo ========================================
echo   FotoAI Servisleri Yeniden Başlatılıyor...
echo ========================================
echo.

echo Servisler durduruluyor...
docker-compose down
echo.

echo Servisler başlatılıyor...
docker-compose up -d
echo.

if %errorLevel% equ 0 (
    echo [OK] Servisler yeniden başlatıldı!
    echo.
    echo Frontend: http://localhost:3000
    echo Backend:  http://localhost:5000
    echo.
) else (
    echo [HATA] Servisler yeniden başlatılamadı!
    echo.
)

pause
