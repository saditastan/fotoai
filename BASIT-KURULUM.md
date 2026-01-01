# FotoAI - Basit Kurulum (Docker Gerektirmez)

Bu versiyon Docker yerine sadece **Node.js** kullanır. Virtualization sorunları olan bilgisayarlarda çalışır.

## Özellikler

✅ Docker gerektirmez
✅ Node.js ile çalışır
✅ Tüm UI/UX özellikleri
✅ Demo verilerle çalışan sistem
❌ Gerçek AI işleme yok (mock data)
❌ RAW işleme simülasyon
❌ Veritabanı yok (tarayıcı storage)

## Gereksinimler

Sadece **Node.js** (v18 veya üzeri)

## Kurulum Adımları

### 1. Node.js Kurulumu

https://nodejs.org/ adresinden **LTS** versiyonunu indirin ve kurun.

Kurulum sonrası kontrol edin:
```bash
node --version
npm --version
```

### 2. Projeyi Başlatın

PowerShell veya CMD'de:
```bash
cd C:\fotoai
npm install
npm run dev
```

### 3. Tarayıcıda Açın

Kurulum bitince (2-3 dakika):
- http://localhost:3000

## Kullanım

**Başlatma:**
```bash
npm run dev
```

**Durdurma:**
CTRL+C tuşlarına basın

## Not

Bu versiyon demo amaçlıdır. Gerçek RAW işleme için Docker ve tam sistem gereklidir.
