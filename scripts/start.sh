#!/bin/bash

echo "🚀 Starting FotoAI Platform..."

# Start all services
docker-compose up -d

echo ""
echo "✓ All services started!"
echo ""
echo "Access the platform at:"
echo "  Frontend: http://localhost:3000"
echo "  Backend API: http://localhost:5000"
echo "  API Docs: http://localhost:5000/swagger"
echo ""
echo "View logs: docker-compose logs -f"
echo "Stop services: docker-compose down"
