@echo off
chcp 65001 >nul
cls

echo =============================================
echo   FotoAI - Otomatik Kurulum
echo =============================================
echo.
echo Kurulum basladi, lutfen bekleyin...
echo.

:: Otomatik yonetici izni al
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Yonetici izni isteniyor...
    goto UACPrompt
) else (
    goto GotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:GotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

echo [ADIM 1/4] Docker kontrol ediliyor...
docker --version >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo HATA: Docker bulunamadi!
    echo.
    echo Lutfen once Docker Desktop kurun:
    echo https://www.docker.com/products/docker-desktop/
    echo.
    echo Kurduktan sonra bu dosyayi tekrar calistirin.
    echo.
    pause
    exit
)
echo OK - Docker bulundu
echo.

echo [ADIM 2/4] Ayar dosyasi olusturuluyor...
if not exist ".env" (
    if exist ".env.example" (
        copy ".env.example" ".env" >nul 2>&1
    ) else (
        (
            echo # FotoAI Configuration
            echo POSTGRES_DB=fotoai
            echo POSTGRES_USER=postgres
            echo POSTGRES_PASSWORD=postgres123
            echo DATABASE_URL=postgresql://postgres:postgres123@db:5432/fotoai
            echo JWT_SECRET=your-super-secret-jwt-key-change-in-production
            echo REDIS_URL=redis://redis:6379
            echo NEXT_PUBLIC_API_URL=http://localhost:5000
        ) > ".env"
    )
)
echo OK - Ayarlar hazir
echo.

echo [ADIM 3/4] Sistem baslatiliyor...
echo Bu islem ilk seferde 5-10 dakika surebilir.
echo Lutfen bekleyin...
echo.
docker-compose up -d
echo.

echo [ADIM 4/4] Servisler kontrol ediliyor...
timeout /t 3 /nobreak >nul
docker-compose ps
echo.

echo =============================================
echo   KURULUM TAMAMLANDI!
echo =============================================
echo.
echo Uygulamayi kullanmak icin tarayicinizda:
echo http://localhost:3000
echo.
echo Komutlar:
echo - BASLA.bat    = Sistemi baslat
echo - DURDUR.bat   = Sistemi durdur  
echo - LOGLAR.bat   = Hatalari gor
echo.
echo Tarayiciniz otomatik acilacak...
timeout /t 3 /nobreak >nul
start http://localhost:3000
pause
