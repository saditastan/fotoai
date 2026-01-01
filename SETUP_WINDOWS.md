# FotoAI Platform - Windows Kurulum Kılavuzu

Bu kılavuz, FotoAI platformunu Windows 10/11 üzerinde kurmanız için adım adım talimatlar içerir.

## Ön Gereksinimler

### 1. Docker Desktop Kurulumu

1. [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/) sayfasından Docker Desktop'ı indirin
2. İndirdiğiniz `.exe` dosyasını çalıştırın
3. Kurulum tamamlandıktan sonra bilgisayarınızı yeniden başlatın
4. Docker Desktop'ı açın ve başlamasını bekleyin

**Sistem Gereksinimleri:**
- Windows 10 64-bit: Pro, Enterprise veya Education (Build 19041 veya üzeri)
- Windows 11 64-bit
- WSL 2 (Windows Subsystem for Linux 2) aktif olmalı
- Minimum 4GB RAM (8GB+ önerilir)
- BIOS'ta sanallaştırma (Virtualization) açık olmalı

### 2. WSL 2 Kurulumu (Otomatik)

Docker Desktop, WSL 2'yi otomatik olarak kuracaktır. Eğer manuel kurmak isterseniz:

```powershell
# PowerShell'i Yönetici olarak açın ve çalıştırın:
wsl --install
```

## Kurulum Adımları

### Adım 1: Dosyaları Hazırlayın

FotoAI ZIP dosyasını `C:\fotoai` klasörüne çıkartın. Yapı şöyle olmalı:

```
C:\fotoai\
├── frontend\
├── backend\
├── ai-services\
├── scripts\
├── docker-compose.yml
└── .env.example
```

### Adım 2: PowerShell'i Yönetici Olarak Açın

1. Başlat menüsünde "PowerShell" yazın
2. "Windows PowerShell" üzerine sağ tıklayın
3. "Yönetici olarak çalıştır" seçin

### Adım 3: Klasöre Gidin

```powershell
cd C:\fotoai
```

### Adım 4: Execution Policy Ayarlayın

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Bu komut, PowerShell scriptlerinin çalışmasına izin verir.

### Adım 5: Kurulumu Başlatın

```powershell
.\scripts\setup.ps1
```

Bu script otomatik olarak:
- Docker'ı kontrol eder
- Gerekli imajları indirir ve oluşturur
- Servisleri başlatır
- Veritabanını hazırlar

**Not:** İlk kurulum 5-10 dakika sürebilir.

## Kurulum Sonrası

Kurulum tamamlandıktan sonra şu adreslerden platformu kullanabilirsiniz:

- **Frontend (Web Arayüzü):** http://localhost:3000
- **Backend API:** http://localhost:5000
- **API Dokümantasyonu:** http://localhost:5000/swagger

## Günlük Kullanım Komutları

### Servisleri Başlatma

```powershell
cd C:\fotoai
.\scripts\start.ps1
```

### Servisleri Durdurma

```powershell
cd C:\fotoai
.\scripts\stop.ps1
```

### Servisleri Yeniden Başlatma

```powershell
cd C:\fotoai
.\scripts\restart.ps1
```

### Logları Görüntüleme

Tüm servislerin logları:
```powershell
cd C:\fotoai
.\scripts\logs.ps1
```

Belirli bir servisin logları:
```powershell
.\scripts\logs.ps1 -Service frontend
.\scripts\logs.ps1 -Service backend
.\scripts\logs.ps1 -Service analysis-service
```

## Ortam Değişkenlerini Yapılandırma

`.env` dosyasını düzenleyin (Notepad veya VS Code ile):

```powershell
notepad .env
```

Önemli ayarlar:

```env
# Veritabanı
DATABASE_URL=postgresql://fotoai:fotoai123@postgres:5432/fotoai

# JWT Token
JWT_SECRET=your-super-secret-jwt-key-change-in-production

# Depolama (Azure Blob veya AWS S3)
AZURE_STORAGE_CONNECTION_STRING=your-connection-string
# veya
AWS_ACCESS_KEY_ID=your-key
AWS_SECRET_ACCESS_KEY=your-secret

# AI Modelleri
OPENAI_API_KEY=your-openai-key  # SEO üretimi için
```

Değişiklikleri kaydettikten sonra servisleri yeniden başlatın:

```powershell
.\scripts\restart.ps1
```

## Sorun Giderme

### Docker başlamıyor

1. Docker Desktop'ın açık olduğundan emin olun
2. Sistem tepsisinde (system tray) Docker ikonuna tıklayın
3. "Docker Desktop is running" yazısını görmelisiniz

### Port çakışması (örn: 3000 veya 5000 kullanımda)

`docker-compose.yml` dosyasını düzenleyin:

```yaml
services:
  frontend:
    ports:
      - "3001:3000"  # 3000 yerine 3001 kullan
```

### Servisleri sıfırlama (tüm verileri siler!)

```powershell
docker-compose down -v
.\scripts\setup.ps1
```

### Docker imajlarını yeniden oluşturma

```powershell
docker-compose build --no-cache
docker-compose up -d
```

## İleri Seviye Komutlar

### Belirli bir servise giriş yapma

```powershell
# Backend container'a gir
docker-compose exec backend bash

# Frontend container'a gir
docker-compose exec frontend sh

# Python servisine gir
docker-compose exec analysis-service bash
```

### Veritabanını manuel güncelleme

```powershell
docker-compose exec backend dotnet ef database update
```

### Tüm container'ları görüntüleme

```powershell
docker-compose ps
```

## Üretim Dağıtımı

Üretim ortamı için:

1. `.env` dosyasındaki tüm şifreleri değiştirin
2. `DEBUG=false` olarak ayarlayın
3. Azure, AWS veya başka bir cloud provider kullanın
4. Güvenlik ayarlarını yapılandırın

Detaylı üretim dağıtım kılavuzu için `docs/DEPLOYMENT.md` dosyasına bakın.

## Destek

Sorun yaşıyorsanız:

1. `.\scripts\logs.ps1` ile logları kontrol edin
2. `docs/` klasöründeki dokümantasyonu okuyun
3. Docker Desktop'ın güncel olduğundan emin olun

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır.
