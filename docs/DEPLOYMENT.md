# FotoAI Deployment Guide

## Production Deployment Options

### 1. Docker Compose (Single Server)

Suitable for small agencies processing <1000 photos/day.

```bash
# Clone repository
git clone <repo-url>
cd fotoai

# Configure production environment
cp .env.example .env
nano .env  # Edit with production values

# Build and start
docker-compose -f docker-compose.prod.yml up -d
```

### 2. Kubernetes (Scalable)

Suitable for brokerages processing 5000+ photos/day.

```bash
# Apply configurations
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/secrets.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployments/
kubectl apply -f k8s/services/
kubectl apply -f k8s/ingress.yaml

# Verify deployment
kubectl get pods -n fotoai
```

### 3. Managed Services (Azure/AWS)

**Azure**:
- App Service for Next.js frontend
- Container Apps for .NET API
- Container Instances for Python AI services
- PostgreSQL Flexible Server
- Azure Cache for Redis
- Azure Blob Storage

**AWS**:
- Amplify for Next.js frontend
- ECS/Fargate for .NET API
- Lambda or ECS for Python AI services
- RDS PostgreSQL
- ElastiCache Redis
- S3 Storage

## Environment Variables

See `.env.example` for required variables.

**Critical Production Settings**:
- Generate strong `JWT_SECRET`
- Use managed database (not container)
- Configure production storage (Azure/S3)
- Set up monitoring and logging
- Enable HTTPS with SSL certificates
- Configure CORS for production domain

## Monitoring

Recommended tools:
- Application Insights (Azure)
- CloudWatch (AWS)
- Sentry for error tracking
- Grafana for metrics
- ELK Stack for log aggregation

## Backup Strategy

1. **Database**: Daily automated backups
2. **File Storage**: Cross-region replication
3. **Configuration**: Version controlled in Git

## Performance Tuning

- Enable CDN for frontend assets
- Configure Redis caching
- Optimize database indexes
- Use GPU instances for AI services
- Implement request throttling
