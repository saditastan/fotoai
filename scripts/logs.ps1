# FotoAI Platform - Windows Logs Script

param(
    [string]$Service = ""
)

Write-Host "FotoAI Service Logs" -ForegroundColor Cyan
Write-Host ""

if ($Service -eq "") {
    Write-Host "Showing logs for all services (Ctrl+C to exit)" -ForegroundColor Yellow
    docker-compose logs -f
} else {
    Write-Host "Showing logs for: $Service (Ctrl+C to exit)" -ForegroundColor Yellow
    docker-compose logs -f $Service
}
