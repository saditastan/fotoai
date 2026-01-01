# FotoAI Platform - Windows Start Script

Write-Host "Starting FotoAI services..." -ForegroundColor Cyan

docker-compose up -d

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Services started successfully" -ForegroundColor Green
    Write-Host ""
    Write-Host "Frontend:  http://localhost:3000" -ForegroundColor White
    Write-Host "Backend:   http://localhost:5000" -ForegroundColor White
    Write-Host "API Docs:  http://localhost:5000/swagger" -ForegroundColor White
} else {
    Write-Host "✗ Failed to start services" -ForegroundColor Red
    exit 1
}
