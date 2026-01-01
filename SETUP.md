# FotoAI - Installation & Setup Guide

## Prerequisites

### Required Software

- **Docker Desktop** 4.25+ (with Docker Compose V2)
- **Node.js** 20+ and npm/pnpm
- **.NET SDK** 8.0+
- **Python** 3.11+
- **Git**

### System Requirements

**Minimum (Development):**
- 16GB RAM
- 50GB free disk space
- 4 CPU cores

**Recommended (Production):**
- 32GB+ RAM
- 500GB+ SSD
- 8+ CPU cores
- GPU (NVIDIA RTX 3060+ or equivalent)

---

## Installation Steps

### 1. Clone Repository

```bash
git clone <repository-url>
cd fotoai
```

### 2. Environment Configuration

```bash
# Copy environment templates
cp .env.example .env
cp frontend/.env.example frontend/.env.local
cp backend/appsettings.example.json backend/appsettings.json
```

Edit `.env` and configure:
- `DATABASE_URL` - PostgreSQL connection string
- `REDIS_URL` - Redis connection string
- `STORAGE_CONNECTION_STRING` - Azure Blob or AWS S3 credentials
- `JWT_SECRET` - Generate with: `openssl rand -base64 32`

### 3. Install Dependencies

#### Frontend
```bash
cd frontend
pnpm install
cd ..
```

#### Backend
```bash
cd backend
dotnet restore
cd ..
```

#### AI Services
```bash
cd ai-services
pip install -r requirements.txt
# For GPU support:
pip install torch torchvision --index-url https://download.pytorch.org/whl/cu118
cd ..
```

### 4. Database Setup

```bash
# Start PostgreSQL
docker-compose up -d postgres

# Run migrations
cd backend
dotnet ef database update
cd ..
```

### 5. Start Services

#### Option A: Docker Compose (Recommended for Development)
```bash
docker-compose up -d
```

#### Option B: Manual (For Development/Debugging)

Terminal 1 - Frontend:
```bash
cd frontend
pnpm dev
```

Terminal 2 - Backend:
```bash
cd backend
dotnet run
```

Terminal 3 - AI Services:
```bash
cd ai-services
python analysis-service/app.py &
python raw-pipeline/app.py &
python jpg-pipeline/app.py &
python seo-service/app.py
```

### 6. Verify Installation

```bash
# Check all services are running
curl http://localhost:3000        # Frontend
curl http://localhost:5000/health # Backend API
curl http://localhost:8001/health # Analysis Service
curl http://localhost:8002/health # RAW Pipeline
curl http://localhost:8003/health # JPG Pipeline
curl http://localhost:8004/health # SEO Service
```

### 7. Create First Admin User

```bash
cd backend
dotnet run --seed-admin
# Default credentials: admin@fotoai.com / Admin123!
```

---

## Development Workflow

### Running Tests

```bash
# Frontend
cd frontend && pnpm test

# Backend
cd backend && dotnet test

# AI Services
cd ai-services && pytest
```

### Database Migrations

```bash
# Create new migration
cd backend
dotnet ef migrations add MigrationName

# Apply migrations
dotnet ef database update
```

### Code Quality

```bash
# Frontend linting
cd frontend && pnpm lint

# Backend formatting
cd backend && dotnet format

# Python formatting
cd ai-services && black . && isort .
```

---

## Troubleshooting

### Port Conflicts
If ports 3000, 5000, 8001-8004 are in use:
```bash
# Kill processes
lsof -ti:3000 | xargs kill -9
```

### Docker Issues
```bash
# Reset Docker environment
docker-compose down -v
docker system prune -a
docker-compose up -d --build
```

### Memory Issues (AI Services)
Edit `docker-compose.yml` and increase memory limits:
```yaml
ai-services:
  deploy:
    resources:
      limits:
        memory: 8G
```

---

## Next Steps

1. Read [ARCHITECTURE.md](./docs/ARCHITECTURE.md) to understand the system
2. Review [API.md](./docs/API.md) for API integration
3. Check [UX-GUIDELINES.md](./docs/UX-GUIDELINES.md) for UI patterns
4. Deploy to production: [DEPLOYMENT.md](./docs/DEPLOYMENT.md)

## Support

For issues and questions:
- GitHub Issues: <repository-url>/issues
- Documentation: <docs-url>
- Email: support@fotoai.com
