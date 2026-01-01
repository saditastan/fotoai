from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import StreamingResponse
from fastapi.middleware.cors import CORSMiddleware
import io
from PIL import Image
from .enhance import enhance_photo
from .utils import validate_image

app = FastAPI(title="FotoAI Backend", version="1.0.0")

# CORS middleware for frontend communication
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000", "http://127.0.0.1:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {
        "service": "FotoAI Backend",
        "status": "running",
        "version": "1.0.0"
    }

@app.get("/health")
def health_check():
    return {"status": "healthy"}

@app.post("/enhance")
async def enhance_image(file: UploadFile = File(...)):
    """
    Enhance real estate photo with automatic adjustments.
    
    Args:
        file: Image file (JPEG, PNG, etc.)
    
    Returns:
        Enhanced image as JPEG
    """
    try:
        # Read uploaded file
        contents = await file.read()
        
        # Validate image
        if not validate_image(contents):
            raise HTTPException(status_code=400, detail="Invalid image format")
        
        # Open image with Pillow
        image = Image.open(io.BytesIO(contents))
        
        # Convert to RGB if necessary
        if image.mode != 'RGB':
            image = image.convert('RGB')
        
        # Apply enhancement pipeline
        enhanced_image = enhance_photo(image)
        
        # Convert to bytes
        output_buffer = io.BytesIO()
        enhanced_image.save(output_buffer, format='JPEG', quality=95, optimize=True)
        output_buffer.seek(0)
        
        return StreamingResponse(
            output_buffer,
            media_type="image/jpeg",
            headers={"Content-Disposition": f"attachment; filename=enhanced_{file.filename}"}
        )
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Enhancement failed: {str(e)}")

@app.post("/analyze")
async def analyze_image(file: UploadFile = File(...)):
    """
    Analyze image characteristics without enhancement.
    Returns metadata about the image.
    """
    try:
        contents = await file.read()
        image = Image.open(io.BytesIO(contents))
        
        # Basic image analysis
        width, height = image.size
        mode = image.mode
        format_type = image.format
        
        return {
            "width": width,
            "height": height,
            "mode": mode,
            "format": format_type,
            "size_bytes": len(contents)
        }
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Analysis failed: {str(e)}")
