from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import StreamingResponse
from pydantic import BaseModel
from typing import Optional
import numpy as np
from PIL import Image
from io import BytesIO
import cv2

app = FastAPI(title="FotoAI JPG Pipeline", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class ProcessingOptions(BaseModel):
    light_mood: float = 0.0
    air: float = 0.0
    depth: float = 0.0
    presence: float = 0.0
    detail: float = 0.0
    output_quality: int = 95

@app.get("/health")
async def health_check():
    return {"status": "healthy", "service": "jpg-pipeline"}

@app.post("/process")
async def process_jpg(
    file: UploadFile = File(...),
    options: Optional[str] = None
):
    """
    Process JPG/PNG image with conservative enhancement
    """
    try:
        # Parse options
        if options:
            import json
            opts = ProcessingOptions(**json.loads(options))
        else:
            opts = ProcessingOptions()
        
        # Read image
        contents = await file.read()
        image = Image.open(BytesIO(contents))
        img_array = np.array(image)
        
        # Convert to float
        img_float = img_array.astype(np.float32) / 255.0
        
        # Apply conservative adjustments (30% strength max)
        strength_multiplier = 0.3
        
        img_float = apply_tone_adjustment(img_float, opts.light_mood * strength_multiplier)
        img_float = apply_color_balance(img_float, opts.presence * strength_multiplier)
        
        # Detect compression artifacts before sharpening
        has_artifacts = detect_compression_artifacts(img_array)
        if not has_artifacts:
            img_float = apply_safe_sharpen(img_float, opts.detail * strength_multiplier)
        
        # Convert back to 8-bit
        img_8bit = (np.clip(img_float, 0, 1) * 255).astype(np.uint8)
        
        # Create output
        output_image = Image.fromarray(img_8bit)
        output_buffer = BytesIO()
        output_image.save(output_buffer, format="JPEG", quality=opts.output_quality)
        output_buffer.seek(0)
        
        return StreamingResponse(
            output_buffer,
            media_type="image/jpeg",
            headers={"Content-Disposition": "attachment; filename=processed.jpg"}
        )
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"JPG processing failed: {str(e)}")

def detect_compression_artifacts(img: np.ndarray) -> bool:
    """Detect JPEG compression artifacts"""
    # TODO: Implement actual artifact detection
    return False

def apply_tone_adjustment(img: np.ndarray, value: float) -> np.ndarray:
    """Gentle tone curve adjustment"""
    # Conservative brightness adjustment
    return img * (1.0 + value * 0.2)

def apply_color_balance(img: np.ndarray, value: float) -> np.ndarray:
    """Preserve skin tones while adjusting colors"""
    # TODO: Implement skin tone preservation
    return img

def apply_safe_sharpen(img: np.ndarray, value: float) -> np.ndarray:
    """Artifact-aware sharpening"""
    if value <= 0:
        return img
    
    # Convert to opencv format
    img_cv = (img * 255).astype(np.uint8)
    
    # Gentle unsharp mask
    blurred = cv2.GaussianBlur(img_cv, (0, 0), 0.8)
    sharpened = cv2.addWeighted(img_cv, 1.0 + value, blurred, -value, 0)
    
    return sharpened.astype(np.float32) / 255.0

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8003)
