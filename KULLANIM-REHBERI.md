# FotoAI Kullanım Rehberi

## Basit Kurulum (Docker Gerektirmez)

### Gereksinimler

- Python 3.10 veya üzeri
- Windows 10/11

### Adım 1: Python Kurulumu

1. https://python.org adresine gidin
2. "Download Python 3.12" (veya en son versiyon) butonuna tıklayın
3. İndirilen dosyayı çalıştırın
4. **ÖNEMLİ:** "Add Python to PATH" kutucuğunu işaretleyin
5. "Install Now" butonuna tıklayın
6. Kurulum bitince bilgisayarı yeniden başlatın

### Adım 2: Backend Kurulumu

1. `C:\fotoai\PYTHON-KURULUM.bat` dosyasına çift tıklayın
2. Kurulum otomatik olarak tamamlanacak (2-3 dakika)
3. "Kurulum tamamlandı!" mesajını görünce kapatın

### Adım 3: Backend'i Başlatın

1. `C:\fotoai\PYTHON-BASLA.bat` dosyasına çift tıklayın
2. "Server başlatılıyor..." mesajını göreceksiniz
3. Pencereyi açık bırakın (backend çalışıyor)

### Adım 4: Test Edin

Tarayıcıda açın:
- API Dokümantasyon: http://localhost:8000/docs
- Health Check: http://localhost:8000/health

### Fotoğraf Geliştirme

API dokümantasyon sayfasından (http://localhost:8000/docs):

1. `/enhance` endpoint'ini açın
2. "Try it out" butonuna tıklayın
3. "Choose File" ile bir fotoğraf seçin
4. "Execute" butonuna tıklayın
5. "Download file" ile geliştirilmiş fotoğrafı indirin

### Durdurma

Backend'i durdurmak için:
- PYTHON-BASLA.bat penceresini kapatın
- Veya `PYTHON-DURDUR.bat` dosyasına çift tıklayın

## Sorun Giderme

**"Python bulunamadı" hatası:**
- Python'u PATH'e ekleyerek yeniden kurun
- Bilgisayarı yeniden başlatın

**Paket yükleme hatası:**
- İnternet bağlantınızı kontrol edin
- Antivirüs yazılımını geçici olarak kapatın

**Port zaten kullanılıyor:**
- 8000 portu başka bir uygulama tarafından kullanılıyor
- Diğer uygulamayı kapatın veya PYTHON-DURDUR.bat çalıştırın

## Frontend Entegrasyonu (Opsiyonel)

Frontend'i de kullanmak istiyorsanız:

1. Node.js kurun: https://nodejs.org
2. `BASIT-BASLA.bat` dosyasına çift tıklayın
3. Frontend: http://localhost:3000
4. Backend: http://localhost:8000

Her ikisi de aynı anda çalışmalı.
