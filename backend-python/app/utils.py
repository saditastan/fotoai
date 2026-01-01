import imghdr
from typing import Optional

def validate_image(image_bytes: bytes) -> bool:
    """
    Validate if uploaded file is a valid image.
    
    Args:
        image_bytes: Raw image file bytes
    
    Returns:
        True if valid image format, False otherwise
    """
    try:
        image_type = imghdr.what(None, h=image_bytes)
        return image_type in ['jpeg', 'png', 'jpg', 'bmp', 'gif', 'tiff', 'webp']
    except Exception:
        return False


def get_image_format(image_bytes: bytes) -> Optional[str]:
    """
    Detect image format from bytes.
    
    Args:
        image_bytes: Raw image file bytes
    
    Returns:
        Format string (e.g., 'jpeg', 'png') or None
    """
    try:
        return imghdr.what(None, h=image_bytes)
    except Exception:
        return None
