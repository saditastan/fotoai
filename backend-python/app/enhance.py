import cv2
import numpy as np
from PIL import Image, ImageEnhance, ImageFilter

def enhance_photo(image: Image.Image) -> Image.Image:
    """
    Apply real estate photo enhancement pipeline.
    
    Pipeline:
    1. Exposure correction
    2. White balance normalization
    3. Contrast enhancement
    4. Highlight recovery & shadow lifting
    5. Warm tone adjustment
    6. Clarity/sharpness enhancement
    
    Args:
        image: PIL Image object
    
    Returns:
        Enhanced PIL Image object
    """
    # Convert PIL to OpenCV format (numpy array)
    img_array = np.array(image)
    img_cv = cv2.cvtColor(img_array, cv2.COLOR_RGB2BGR)
    
    # Step 1: Auto exposure correction
    img_cv = auto_exposure_correction(img_cv)
    
    # Step 2: White balance normalization
    img_cv = white_balance_correction(img_cv)
    
    # Step 3: Highlight recovery and shadow lifting
    img_cv = dynamic_range_optimization(img_cv)
    
    # Step 4: Apply warm tone for interior friendliness
    img_cv = apply_warm_tone(img_cv, strength=0.15)
    
    # Convert back to PIL for final adjustments
    img_rgb = cv2.cvtColor(img_cv, cv2.COLOR_BGR2RGB)
    img_pil = Image.fromarray(img_rgb)
    
    # Step 5: Contrast enhancement (soft, natural)
    contrast_enhancer = ImageEnhance.Contrast(img_pil)
    img_pil = contrast_enhancer.enhance(1.15)
    
    # Step 6: Clarity/sharpness
    img_pil = img_pil.filter(ImageFilter.UnsharpMask(radius=1.5, percent=120, threshold=3))
    
    # Step 7: Vibrance boost (saturation, but subtle)
    color_enhancer = ImageEnhance.Color(img_pil)
    img_pil = color_enhancer.enhance(1.12)
    
    return img_pil


def auto_exposure_correction(img: np.ndarray) -> np.ndarray:
    """
    Automatically adjust exposure to optimal brightness.
    Targets mean luminance around 128 (mid-gray).
    """
    # Convert to LAB color space
    lab = cv2.cvtColor(img, cv2.COLOR_BGR2LAB)
    l_channel, a_channel, b_channel = cv2.split(lab)
    
    # Calculate current mean brightness
    current_mean = np.mean(l_channel)
    target_mean = 128
    
    # Apply adaptive correction
    correction_factor = target_mean / current_mean if current_mean > 0 else 1.0
    correction_factor = np.clip(correction_factor, 0.8, 1.3)  # Prevent extreme changes
    
    # Adjust L channel
    l_channel = np.clip(l_channel * correction_factor, 0, 255).astype(np.uint8)
    
    # Merge and convert back
    lab = cv2.merge([l_channel, a_channel, b_channel])
    return cv2.cvtColor(lab, cv2.COLOR_LAB2BGR)


def white_balance_correction(img: np.ndarray) -> np.ndarray:
    """
    Normalize white balance using gray world assumption.
    Makes whites appear clean and neutral.
    """
    result = cv2.cvtColor(img, cv2.COLOR_BGR2LAB)
    avg_a = np.average(result[:, :, 1])
    avg_b = np.average(result[:, :, 2])
    
    # Apply correction to remove color cast
    result[:, :, 1] = result[:, :, 1] - ((avg_a - 128) * 0.8)
    result[:, :, 2] = result[:, :, 2] - ((avg_b - 128) * 0.8)
    
    return cv2.cvtColor(result, cv2.COLOR_LAB2BGR)


def dynamic_range_optimization(img: np.ndarray) -> np.ndarray:
    """
    Recover highlights and lift shadows without losing detail.
    Uses tone mapping for natural HDR effect.
    """
    # Convert to float32 for precision
    img_float = img.astype(np.float32) / 255.0
    
    # Apply adaptive histogram equalization (CLAHE) per channel
    lab = cv2.cvtColor(img, cv2.COLOR_BGR2LAB)
    l_channel, a_channel, b_channel = cv2.split(lab)
    
    # CLAHE for luminance channel
    clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8, 8))
    l_channel = clahe.apply(l_channel)
    
    # Merge and convert back
    lab = cv2.merge([l_channel, a_channel, b_channel])
    result = cv2.cvtColor(lab, cv2.COLOR_LAB2BGR)
    
    return result


def apply_warm_tone(img: np.ndarray, strength: float = 0.15) -> np.ndarray:
    """
    Add subtle warm tone to make interiors feel inviting.
    
    Args:
        img: BGR image
        strength: Warmth intensity (0.0 to 1.0)
    """
    # Create warm tone overlay
    warm_overlay = img.copy()
    
    # Increase red channel slightly
    warm_overlay[:, :, 2] = np.clip(warm_overlay[:, :, 2] * (1 + strength * 0.5), 0, 255)
    
    # Decrease blue channel slightly
    warm_overlay[:, :, 0] = np.clip(warm_overlay[:, :, 0] * (1 - strength * 0.3), 0, 255)
    
    # Blend original with warm overlay
    result = cv2.addWeighted(img, 1 - strength, warm_overlay, strength, 0)
    
    return result.astype(np.uint8)
