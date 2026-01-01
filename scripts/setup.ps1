# FotoAI Platform - Windows Setup Script
# Run as Administrator: powershell -ExecutionPolicy Bypass -File scripts/setup.ps1

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  FotoAI Platform - Windows Setup    " -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Check if Docker Desktop is installed
Write-Host "[1/6] Checking Docker Desktop..." -ForegroundColor Yellow
try {
    docker --version | Out-Null
    Write-Host "✓ Docker Desktop found" -ForegroundColor Green
} catch {
    Write-Host "✗ Docker Desktop not found" -ForegroundColor Red
    Write-Host "Please install Docker Desktop from: https://www.docker.com/products/docker-desktop/" -ForegroundColor Yellow
    exit 1
}

# Check if Docker is running
Write-Host "[2/6] Checking Docker service..." -ForegroundColor Yellow
try {
    docker ps | Out-Null
    Write-Host "✓ Docker is running" -ForegroundColor Green
} catch {
    Write-Host "✗ Docker is not running" -ForegroundColor Red
    Write-Host "Please start Docker Desktop and try again" -ForegroundColor Yellow
    exit 1
}

# Copy environment file
Write-Host "[3/6] Setting up environment variables..." -ForegroundColor Yellow
if (Test-Path ".env") {
    Write-Host "✓ .env file already exists" -ForegroundColor Green
} else {
    Copy-Item ".env.example" ".env"
    Write-Host "✓ Created .env file from .env.example" -ForegroundColor Green
    Write-Host "⚠ Please edit .env file with your configuration" -ForegroundColor Yellow
}

# Build Docker images
Write-Host "[4/6] Building Docker images (this may take 5-10 minutes)..." -ForegroundColor Yellow
docker-compose build
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Docker images built successfully" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to build Docker images" -ForegroundColor Red
    exit 1
}

# Start services
Write-Host "[5/6] Starting services..." -ForegroundColor Yellow
docker-compose up -d
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Services started successfully" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to start services" -ForegroundColor Red
    exit 1
}

# Wait for services to be ready
Write-Host "[6/6] Waiting for services to be ready..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Initialize database
Write-Host "Initializing database..." -ForegroundColor Yellow
docker-compose exec -T backend dotnet ef database update
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Database initialized" -ForegroundColor Green
} else {
    Write-Host "⚠ Database initialization may have failed" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  Setup Complete!                     " -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Services are running at:" -ForegroundColor Green
Write-Host "  Frontend:  http://localhost:3000" -ForegroundColor White
Write-Host "  Backend:   http://localhost:5000" -ForegroundColor White
Write-Host "  API Docs:  http://localhost:5000/swagger" -ForegroundColor White
Write-Host ""
Write-Host "To stop services:    .\scripts\stop.ps1" -ForegroundColor Yellow
Write-Host "To view logs:        .\scripts\logs.ps1" -ForegroundColor Yellow
Write-Host "To restart:          .\scripts\restart.ps1" -ForegroundColor Yellow
Write-Host ""
