@echo off
chcp 65001 > nul
cd backend-python

echo ================================
echo FotoAI Python Backend Başlatılıyor...
echo ================================
echo.

call venv\Scripts\activate.bat

echo Server başlatılıyor...
echo URL: http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo.

uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
