@echo off
chcp 65001 >nul
cls

echo ========================================
echo   FotoAI Platform Kurulumu
echo ========================================
echo.

:: Yönetici izni kontrolü
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [HATA] Bu dosya yönetici izniyle çalıştırılmalı!
    echo.
    echo Lütfen dosyaya sağ tıklayıp "Yönetici olarak çalıştır" seçin.
    echo.
    pause
    exit /b 1
)

echo [1/5] Docker kontrolü yapılıyor...
docker --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [HATA] Docker bulunamadı!
    echo.
    echo Lütfen Docker Desktop'ı indirip kurun:
    echo https://www.docker.com/products/docker-desktop/
    echo.
    pause
    exit /b 1
)
echo [OK] Docker bulundu
echo.

echo [2/5] PowerShell execution policy ayarlanıyor...
powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"
echo [OK] Execution policy ayarlandı
echo.

echo [3/5] .env dosyası oluşturuluyor...
if not exist ".env" (
    copy ".env.example" ".env" >nul 2>&1
    if exist ".env" (
        echo [OK] .env dosyası oluşturuldu
    ) else (
        echo [HATA] .env dosyası oluşturulamadı
        pause
        exit /b 1
    )
) else (
    echo [OK] .env dosyası zaten mevcut
)
echo.

echo [4/5] Docker servisleri başlatılıyor...
echo Bu işlem ilk çalıştırmada 5-10 dakika sürebilir...
echo.
docker-compose up -d --build
if %errorLevel% neq 0 (
    echo [HATA] Docker servisleri başlatılamadı!
    echo.
    pause
    exit /b 1
)
echo.
echo [OK] Docker servisleri başlatıldı
echo.

echo [5/5] Servis durumları kontrol ediliyor...
timeout /t 5 /nobreak >nul
docker-compose ps
echo.

echo ========================================
echo   KURULUM TAMAMLANDI!
echo ========================================
echo.
echo Frontend:  http://localhost:3000
echo Backend:   http://localhost:5000
echo Swagger:   http://localhost:5000/swagger
echo.
echo Servisleri durdurmak için: DURDUR.bat
echo Logları görmek için:       LOGLAR.bat
echo.
pause
