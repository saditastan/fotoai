# FotoAI API Reference

## Base URL

**Development**: `http://localhost:5000/api/v1`  
**Production**: `https://api.fotoai.com/api/v1`

## Authentication

All API requests require authentication using JWT Bearer tokens or API Keys.

```http
Authorization: Bearer {your_jwt_token}
```

Or:

```http
X-API-Key: {your_api_key}
```

## Endpoints

### Projects

#### Create Project
```http
POST /projects
Content-Type: application/json

{
  "name": "123 Main St Listing",
  "external_id": "crm-listing-789",
  "metadata": {
    "address": "123 Main St",
    "listing_type": "residential"
  }
}
```

**Response 201**:
```json
{
  "project_id": "550e8400-e29b-41d4-a716-446655440000",
  "upload_url": "/api/v1/projects/{id}/photos",
  "status": "created",
  "created_at": "2026-01-15T10:30:00Z"
}
```

#### Get Project
```http
GET /projects/{project_id}
```

#### List Projects
```http
GET /projects?page=1&limit=20
```

#### Delete Project
```http
DELETE /projects/{project_id}
```

### Photos

#### Upload Photos
```http
POST /projects/{project_id}/photos
Content-Type: multipart/form-data

files: [photo1.dng, photo2.jpg, ...]
```

#### Get Photo
```http
GET /projects/{project_id}/photos/{photo_id}
```

#### List Photos
```http
GET /projects/{project_id}/photos
```

### Processing Jobs

#### Start Batch Processing
```http
POST /projects/{project_id}/jobs/batch-process

{
  "photo_ids": ["a1b2c3d4", "e5f6g7h8"],
  "options": {
    "auto_enhance": true,
    "suggest_privacy_blur": true,
    "generate_seo": true
  }
}
```

#### Check Job Status
```http
GET /jobs/{job_id}
```

**Response 200**:
```json
{
  "job_id": "job-123",
  "status": "processing",
  "progress": {
    "total": 50,
    "completed": 7,
    "current_photo": "photo2.jpg"
  }
}
```

## Webhooks

Configure webhook URLs to receive real-time updates:

```json
{
  "event": "job.completed",
  "job_id": "job-123",
  "project_id": "550e8400...",
  "timestamp": "2026-01-15T10:35:00Z",
  "data": {
    "total_photos": 50,
    "successfully_processed": 48,
    "failed": 2
  }
}
```

## Error Codes

- `400` - Bad Request (validation error)
- `401` - Unauthorized (missing/invalid token)
- `404` - Not Found
- `429` - Too Many Requests (rate limited)
- `500` - Internal Server Error
