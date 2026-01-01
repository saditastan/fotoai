# FotoAI Platform - Windows Stop Script

Write-Host "Stopping FotoAI services..." -ForegroundColor Cyan

docker-compose down

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Services stopped successfully" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to stop services" -ForegroundColor Red
    exit 1
}
