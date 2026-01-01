# FotoAI Platform - Kullanım Kılavuzu

## Hızlı Başlangıç

### 1. İlk Kurulum

**KURULUM.bat** dosyasına **sağ tıklayın** → **"Yönetici olarak çalıştır"**

Bu dosya:
- Docker'ı kontrol eder
- Gerekli ayarları yapar
- Tüm servisleri kurar ve başlatır
- İlk çalıştırmada 5-10 dakika sürebilir

### 2. Günlük Kullanım

#### Servisleri Başlatma
**BASLA.bat** dosyasına çift tıklayın

#### Servisleri Durdurma
**DURDUR.bat** dosyasına çift tıklayın

#### Servisleri Yeniden Başlatma
**YENIDEN-BASLA.bat** dosyasına çift tıklayın

#### Logları Görüntüleme
**LOGLAR.bat** dosyasına çift tıklayın ve bir servis seçin

## Erişim Adresleri

Servisler başladıktan sonra:

- **Frontend (Kullanıcı Arayüzü):** http://localhost:3000
- **Backend API:** http://localhost:5000
- **API Dokümantasyonu:** http://localhost:5000/swagger

## Sorun Giderme

### Docker Hatası
Eğer "Docker bulunamadı" hatası alırsanız:
1. Docker Desktop'ı başlatın
2. Docker'ın tamamen açılmasını bekleyin
3. Tekrar deneyin

### Port Meşgul Hatası
Eğer port zaten kullanımda hatası alırsanız:
1. DURDUR.bat'ı çalıştırın
2. 10 saniye bekleyin
3. BASLA.bat'ı çalıştırın

### Temizlik ve Yeniden Kurulum
Eğer ciddi bir sorun varsa:
1. **TEMIZLE.bat** dosyasına **sağ tıklayın** → **"Yönetici olarak çalıştır"**
2. Tüm verileri siler (dikkat!)
3. **KURULUM.bat** dosyasını tekrar çalıştırın

## Yardım

Daha fazla teknik detay için:
- **README.md** - Genel bilgiler
- **SETUP.md** - Detaylı kurulum
- **SETUP_WINDOWS.md** - Windows özel notlar
