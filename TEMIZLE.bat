@echo off
chcp 65001 >nul
cls

echo ========================================
echo   FotoAI Temizleme
echo ========================================
echo.
echo UYARI: Bu işlem şunları silecek:
echo - Tüm Docker container'ları
echo - Tüm Docker volume'ları (veritabanı dahil)
echo - Tüm Docker image'ları
echo.

set /p confirm="Devam etmek istediğinize emin misiniz? (E/H): "

if /i not "%confirm%"=="E" (
    echo İşlem iptal edildi.
    pause
    exit /b 0
)

echo.
echo Servisler durduruluyor ve temizleniyor...
docker-compose down -v --rmi all

if %errorLevel% equ 0 (
    echo.
    echo [OK] Temizleme tamamlandı!
    echo.
    echo Yeniden kurmak için KURULUM.bat dosyasını çalıştırın.
    echo.
) else (
    echo.
    echo [HATA] Temizleme sırasında bir hata oluştu!
    echo.
)

pause
