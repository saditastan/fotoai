# fotoAI - AI-Powered Real Estate Photo Enhancement Platform

**Production-grade photo enhancement platform for real estate professionals**

## Architecture

- **Frontend**: Next.js 16 (App Router) with TypeScript
- **Backend API**: .NET 8/9 Web API (Clean Architecture)
- **AI Services**: Python 3.11+ Microservices
- **Database**: PostgreSQL
- **Queue**: Redis + Hangfire
- **Storage**: Azure Blob Storage / AWS S3

## Key Features

✅ Bulk photo upload (50-150+ images)  
✅ RAW format detection and specialized processing  
✅ AI-powered enhancement (Light Mood, Air, Depth, Presence, Detail)  
✅ Privacy blur system with object detection  
✅ SEO metadata generation  
✅ CRM API integration  
✅ Real-time batch processing with progress tracking  

## Quick Start

### Linux / macOS

```bash
# 1. Clone repository
git clone <repository-url>
cd fotoai

# 2. Run setup script
./scripts/setup.sh

# 3. Start all services
docker-compose up -d

# 4. Access platform
# Frontend: http://localhost:3000
# API: http://localhost:5000
# API Docs: http://localhost:5000/swagger
```

### Windows

```powershell
# 1. Extract ZIP to C:\fotoai
# 2. Open PowerShell as Administrator
cd C:\fotoai

# 3. Allow script execution
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 4. Run setup script
.\scripts\setup.ps1

# 5. Access platform
# Frontend: http://localhost:3000
# API: http://localhost:5000
# API Docs: http://localhost:5000/swagger
```

For detailed installation instructions:
- **Windows**: See [SETUP_WINDOWS.md](./SETUP_WINDOWS.md)
- **Linux/macOS**: See [SETUP.md](./SETUP.md)

## Documentation

- [System Architecture](./docs/ARCHITECTURE.md)
- [API Reference](./docs/API.md)
- [UX Guidelines](./docs/UX-GUIDELINES.md)
- [Deployment Guide](./docs/DEPLOYMENT.md)

## Project Structure

```
fotoai/
├── frontend/              # Next.js application
├── backend/               # .NET Web API
├── ai-services/           # Python microservices
├── docs/                  # Documentation
├── scripts/               # Setup and deployment scripts
└── docker-compose.yml     # Local development environment
```

## License

Proprietary - All Rights Reserved
