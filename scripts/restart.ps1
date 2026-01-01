# FotoAI Platform - Windows Restart Script

Write-Host "Restarting FotoAI services..." -ForegroundColor Cyan

docker-compose restart

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Services restarted successfully" -ForegroundColor Green
    Write-Host ""
    Write-Host "Frontend:  http://localhost:3000" -ForegroundColor White
    Write-Host "Backend:   http://localhost:5000" -ForegroundColor White
} else {
    Write-Host "✗ Failed to restart services" -ForegroundColor Red
    exit 1
}
