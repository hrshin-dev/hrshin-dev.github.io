from PIL import Image
import os

def convert_image(input_path, output_path, size):
    with Image.open(input_path) as img:
        # Convert to RGBA if not already
        if img.mode != 'RGBA':
            img = img.convert('RGBA')
        
        # Resize image
        img = img.resize((size, size), Image.Resampling.LANCZOS)
        
        # Save the image
        if output_path.endswith('.ico'):
            img.save(output_path, 'ICO')
        else:
            img.save(output_path, 'PNG')

def main():
    input_path = 'assets/img/favicons/thumbnail.jpg'
    output_dir = 'assets/img/favicons'
    
    # Define sizes for different favicon files
    sizes = {
        'favicon-16x16.png': 16,
        'favicon-32x32.png': 32,
        'apple-touch-icon.png': 180,
        'android-chrome-192x192.png': 192,
        'android-chrome-512x512.png': 512,
        'mstile-150x150.png': 150,
        'favicon.ico': 32  # ICO 파일은 32x32 크기로 생성
    }
    
    # Convert for each size
    for filename, size in sizes.items():
        output_path = os.path.join(output_dir, filename)
        convert_image(input_path, output_path, size)
        print(f'Created {filename}')

if __name__ == '__main__':
    main() 