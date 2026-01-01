# Hızlı Başlangıç - Bulut Deployment

## Git Kurulumu (İlk Kez)

Git yoksa indirin: https://git-scm.com/download/win

PowerShell'de kontrol edin:
```bash
git --version
```

## Tek Komutla Başlat

C:\fotoai klasöründe PowerShell'de:

```bash
# 1. Git başlat
git init
git add .
git commit -m "FotoAI initial commit"

# 2. GitHub'a push (önce GitHub'da repository oluşturun)
git remote add origin https://github.com/KULLANICI_ADINIZ/fotoai.git
git push -u origin main
```

## Sonra

1. Railway'e gidin → Deploy from GitHub → fotoai seçin
2. Vercel'e gidin → Import Project → fotoai seçin → Root: frontend

Bitti! 5 dakikada canlı.

## Destek

Sorun mu var? BULUT-KURULUM.md dosyasını okuyun.
