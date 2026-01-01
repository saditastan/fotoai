@echo off
chcp 65001 >nul
echo.
echo ========================================
echo   FotoAI - Basit Versiyon Başlatılıyor
echo ========================================
echo.

cd /d "%~dp0"

echo Node.js kontrolü...
node --version >nul 2>&1
if errorlevel 1 (
    echo HATA: Node.js kurulu değil!
    echo.
    echo https://nodejs.org adresinden Node.js indirin ve kurun.
    echo.
    pause
    exit /b 1
)

echo Node.js bulundu!
echo.

echo Bağımlılıklar kontrol ediliyor...
if not exist "node_modules" (
    echo Bağımlılıklar kuruluyor... (İlk kez biraz sürer)
    call npm install
)

echo.
echo FotoAI başlatılıyor...
echo.
echo Tarayıcınızda http://localhost:3000 adresini açın
echo.
echo Durdurmak için CTRL+C tuşlarına basın
echo.

call npm run dev

pause
