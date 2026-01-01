#!/bin/bash

# GitHub için projeyi hazırla
echo "GitHub için hazırlanıyor..."

# .env dosyasını gitignore'a ekle
if ! grep -q ".env" .gitignore; then
    echo ".env" >> .gitignore
    echo ".env.local" >> .gitignore
fi

# README güncelle
cat > README.md << 'EOF'
# FotoAI - Profesyonel Gayrimenkul Fotoğraf İşleme Platformu

AI destekli RAW fotoğraf işleme platformu.

## Özellikler

- RAW format desteği (DNG, NEF, CR2, ARW, RAF, ORF, RW2)
- Toplu fotoğraf yükleme ve işleme
- Akıllı privacy blur sistemi
- SEO optimizasyonu
- CRM entegrasyonu API'si

## Deployment

Detaylı kurulum için `BULUT-KURULUM.md` dosyasına bakın.

### Hızlı Başlangıç

1. Railway'e deploy edin: [![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new)
2. Vercel'e frontend deploy edin: [![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new)

## Lisans

Özel lisans - Tüm hakları saklıdır.
EOF

echo "Hazır! Şimdi şu komutları çalıştırın:"
echo ""
echo "git init"
echo "git add ."
echo "git commit -m 'Initial commit'"
echo "git remote add origin https://github.com/KULLANICI_ADINIZ/fotoai.git"
echo "git push -u origin main"
