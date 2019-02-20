import UIKit


public struct Penceil {
    public var pixels: UnsafeMutableBufferPointer<Pixel>
    
    public var width: Int
    public var height: Int
    
    public init?(image: UIImage) {
        guard let cgImage = image.cgImage else { return nil }
        
        // Redraw image for correct pixel format
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue
        bitmapInfo |= CGImageAlphaInfo.premultipliedLast.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
        
        width = Int(image.size.width)
        height = Int(image.size.height)
        let bytesPerRow = width * 4
        
        let imageData = UnsafeMutablePointer<Pixel>.allocate(capacity: (width * height))
        
        guard let imageContext = CGContext(data: imageData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo) else { return nil }
        
        imageContext.draw(cgImage, in: CGRect(origin: .zero, size: image.size))
        
        //let bufferPointer = UnsafeMutableBufferPointer<Pixel>(start: imageData, count: width * height)
        pixels = UnsafeMutableBufferPointer<Pixel>(start: imageData, count: width * height)
        
        let avgRed = 118
        let avgGreen = 98
        let avgBlue = 83
        
        for y in 0..<height{
            for x in 0..<width{
                let index = y * width + x
                var pixel = pixels[index]
                let redDiff = (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue))/3
                let greenDiff = (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue))/3
                let bluuDiff = (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue))/3
                    pixel.red = UInt8(max(0, min(255, avgRed + redDiff )))
                    pixel.green = UInt8(max(0, min(255, avgGreen + greenDiff )))
                    pixel.blue = UInt8(max(0, min(255, avgBlue + bluuDiff )))
                    pixels[index] = pixel
            }
        }
    }
    
    public func toUIImage() -> UIImage? {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue
        let bytesPerRow = width * 4
        
        bitmapInfo |= CGImageAlphaInfo.premultipliedLast.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
        
        guard let imageContext = CGContext(data: pixels.baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo, releaseCallback: nil, releaseInfo: nil) else {
            return nil
        }
        
        guard let cgImage = imageContext.makeImage() else {
            return nil
        }
        
        let image = UIImage(cgImage: cgImage)
        return image
    }
}
