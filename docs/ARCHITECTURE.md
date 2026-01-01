# FotoAI System Architecture

## Overview

FotoAI is built on a three-tier architecture designed for scalability, maintainability, and production-grade performance.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                        │
│  Next.js 16 (App Router) - Server + Client Components       │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                    APPLICATION LAYER                         │
│  .NET 8/9 Web API (Clean Architecture + CQRS)                │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                    AI PROCESSING LAYER                       │
│  Python 3.11+ Microservices (Stateless)                     │
└─────────────────────────────────────────────────────────────┘
```

## Technology Stack

### Frontend
- **Framework**: Next.js 16 with App Router
- **Language**: TypeScript
- **Styling**: Tailwind CSS v4
- **State**: SWR for server state
- **Animation**: Framer Motion
- **UI Components**: Radix UI primitives

### Backend
- **Framework**: ASP.NET Core 8/9
- **Architecture**: Clean Architecture + CQRS (MediatR)
- **Database**: PostgreSQL with Entity Framework Core
- **Queue**: Hangfire with Redis
- **Storage**: Azure Blob Storage / AWS S3
- **Authentication**: JWT Bearer tokens

### AI Services
- **Framework**: FastAPI (Python)
- **Image Processing**: OpenCV, Pillow, RawPy
- **ML Models**: PyTorch, Transformers
- **Deployment**: Stateless microservices

## Data Flow

See SETUP.md section 6 for detailed end-to-end data flow example.

## Scalability Strategy

### Horizontal Scaling
- All services are stateless
- Database connection pooling
- Redis-based distributed queue
- CDN for static assets

### Vertical Scaling
- GPU acceleration for AI services
- Memory-optimized processing
- Aggressive garbage collection between jobs

## Security

- JWT-based authentication
- CORS configuration
- API rate limiting
- Input validation
- Secure file upload handling
- Environment-based secrets management
