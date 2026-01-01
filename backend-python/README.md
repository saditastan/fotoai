# FotoAI Python Backend

Production-ready FastAPI backend for real estate photo enhancement.

## Features

- Automatic photo enhancement optimized for real estate
- Exposure correction and white balance normalization
- Highlight recovery and shadow lifting
- Warm tone adjustment for interior appeal
- Natural contrast and clarity enhancement
- No Docker required - runs locally with Python

## Tech Stack

- Python 3.10+
- FastAPI
- OpenCV (opencv-python-headless)
- Pillow
- NumPy

## Setup

### 1. Install Python

Download Python 3.10+ from https://python.org

### 2. Create Virtual Environment

```bash
cd backend-python
python -m venv venv
```

### 3. Activate Virtual Environment

**Windows:**
```bash
venv\Scripts\activate
```

**Mac/Linux:**
```bash
source venv/bin/activate
```

### 4. Install Dependencies

```bash
pip install -r requirements.txt
```

### 5. Run Server

```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

Server will start at http://localhost:8000

## API Endpoints

### POST /enhance

Enhance a real estate photo.

**Request:**
- Method: POST
- Content-Type: multipart/form-data
- Body: file (image file)

**Response:**
- Content-Type: image/jpeg
- Body: Enhanced image bytes

**Example:**
```bash
curl -X POST http://localhost:8000/enhance \
  -F "file=@photo.jpg" \
  --output enhanced.jpg
```

### POST /analyze

Analyze image characteristics without enhancement.

**Request:**
- Method: POST
- Content-Type: multipart/form-data
- Body: file (image file)

**Response:**
```json
{
  "width": 1920,
  "height": 1080,
  "mode": "RGB",
  "format": "JPEG",
  "size_bytes": 524288
}
```

### GET /health

Health check endpoint.

**Response:**
```json
{
  "status": "healthy"
}
```

## Enhancement Pipeline

The enhancement pipeline applies the following transformations:

1. **Auto Exposure Correction** - Adjusts brightness to optimal levels
2. **White Balance Normalization** - Makes whites clean and neutral
3. **Dynamic Range Optimization** - Recovers highlights, lifts shadows
4. **Warm Tone Application** - Adds inviting warmth to interiors
5. **Contrast Enhancement** - Soft, natural contrast boost
6. **Clarity/Sharpness** - UnsharpMask for enhanced detail
7. **Vibrance Boost** - Subtle color saturation increase

All adjustments are optimized to look natural and premium.

## Performance

- Optimized for CPU execution
- No GPU required
- Average processing time: 1-3 seconds per image
- Supports images up to 4K resolution

## Future Extensions

The codebase is structured to easily add:
- ML-based segmentation models
- RAW image processing
- Batch processing queues
- Advanced AI enhancement models
```

```batch file="PYTHON-KURULUM.bat"
@echo off
chcp 65001 > nul
echo ================================
echo FotoAI Python Backend Kurulum
echo ================================
echo.

cd backend-python

echo [1/4] Python versiyonu kontrol ediliyor...
python --version
if errorlevel 1 (
    echo HATA: Python bulunamadı!
    echo Python 3.10+ indirin: https://python.org
    pause
    exit /b 1
)
echo.

echo [2/4] Virtual environment oluşturuluyor...
python -m venv venv
if errorlevel 1 (
    echo HATA: Virtual environment oluşturulamadı!
    pause
    exit /b 1
)
echo.

echo [3/4] Virtual environment aktive ediliyor...
call venv\Scripts\activate.bat
echo.

echo [4/4] Paketler yükleniyor (2-3 dakika sürebilir)...
pip install -r requirements.txt
if errorlevel 1 (
    echo HATA: Paketler yüklenemedi!
    pause
    exit /b 1
)
echo.

echo ================================
echo Kurulum tamamlandı!
echo ================================
echo.
echo Başlatmak için: PYTHON-BASLA.bat
echo.
pause
