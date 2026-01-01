# FotoAI Bulut Kurulum Rehberi

## Adım 1: GitHub'a Yükleyin

### 1.1. GitHub hesabı açın
- https://github.com adresine gidin
- "Sign up" ile ücretsiz hesap açın

### 1.2. Yeni repository oluşturun
- Sağ üstten "+" → "New repository"
- İsim: `fotoai`
- Public seçin
- "Create repository" butonuna tıklayın

### 1.3. Kodu yükleyin
PowerShell'de (C:\fotoai klasöründe):

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/KULLANICI_ADINIZ/fotoai.git
git push -u origin main
```

(KULLANICI_ADINIZ yerine GitHub kullanıcı adınızı yazın)

---

## Adım 2: Railway'e Backend Deploy Edin

### 2.1. Railway hesabı açın
- https://railway.app adresine gidin
- "Start a New Project" butonuna tıklayın
- GitHub ile giriş yapın

### 2.2. Projeyi deploy edin
- "Deploy from GitHub repo" seçin
- `fotoai` repository'sini seçin
- Railway otomatik olarak Docker'ı algılayacak

### 2.3. Environment variables ekleyin
Railway dashboard'da:
- Settings → Variables
- Aşağıdaki değişkenleri ekleyin:
  - `DATABASE_URL`: (Railway otomatik PostgreSQL ekleyecek)
  - `REDIS_URL`: (Railway otomatik Redis ekleyecek)
  - `NEXTAUTH_SECRET`: (rastgele 32 karakter)

### 2.4. Domain'i kopyalayın
- Railway size bir URL verecek: `https://fotoai-backend-production.up.railway.app`
- Bu URL'i kopyalayın

---

## Adım 3: Vercel'e Frontend Deploy Edin

### 3.1. Vercel hesabı açın
- https://vercel.com adresine gidin
- GitHub ile giriş yapın

### 3.2. Projeyi import edin
- "Add New..." → "Project"
- `fotoai` repository'sini seçin
- Root Directory: `frontend`

### 3.3. Environment variables ekleyin
- `NEXT_PUBLIC_API_URL`: Railway'den kopyaladığınız backend URL
- `NEXTAUTH_SECRET`: (Railway'dekiyle aynı)

### 3.4. Deploy butonuna basın
- Vercel otomatik build edecek
- 2-3 dakika sonra canlı olacak
- Size bir URL verecek: `https://fotoai.vercel.app`

---

## Sonuç

Frontend URL'inizi tarayıcıda açın. FotoAI çalışıyor!

- Tüm servisler bulutta çalışıyor
- RAW işleme tam çalışır
- Bilgisayarınızda hiçbir şey kurmanıza gerek yok

**Maliyet:**
- İlk ay ücretsiz
- Sonrası: ~$5-20/ay (kullanıma göre)
