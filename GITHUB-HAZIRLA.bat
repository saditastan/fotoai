@echo off
echo ================================================
echo FotoAI - GitHub Hazirlama
echo ================================================
echo.

REM Git kontrolu
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [HATA] Git kurulu degil!
    echo.
    echo Git'i indirin: https://git-scm.com/download/win
    echo Kurduktan sonra bu dosyayi tekrar calistirin.
    pause
    exit /b 1
)

echo [OK] Git kurulu
echo.

REM .gitignore guncelle
echo .env >> .gitignore
echo .env.local >> .gitignore
echo node_modules >> .gitignore
echo __pycache__ >> .gitignore

echo [OK] .gitignore guncellendi
echo.

echo Simdi GitHub'da yeni repository olusturun:
echo 1. https://github.com adresine gidin
echo 2. "New repository" tiklayin
echo 3. Isim: fotoai
echo 4. Public secin
echo 5. "Create repository" tiklayin
echo.
echo Repository olusturduktan sonra kullanici adinizi girin:
echo.
set /p GITHUB_USER="GitHub kullanici adiniz: "

echo.
echo [HAZIRLANIYOR] Git repository olusturuluyor...
echo.

git init
git add .
git commit -m "FotoAI initial commit"
git branch -M main
git remote add origin https://github.com/%GITHUB_USER%/fotoai.git

echo.
echo [OK] Git repository hazir!
echo.
echo Simdi GitHub'a yuklemek icin:
echo.
echo   git push -u origin main
echo.
echo Bu komutu calistirdiginizda GitHub kullanici adi ve token isteyecek.
echo Token olusturmak icin: https://github.com/settings/tokens
echo.
pause
