import UIKit

class ImageLoader {
    
    static func loadImage(url: String, completed: @escaping (UIImage?) -> Void) {
        if url.isEmpty {
            completed(nil)
            return
        }
        
        if !loadFromCache(url: url, completed: completed) {
            loadFromUrl(url: url, completed: completed)
        }
    }
    
    static private func loadFromCache(url: String, completed: @escaping (UIImage?) -> Void) -> Bool {
        let cache = ImageCache.getImageCache()
        
        guard let cacheImage = cache.get(forKey: url) else { return false }
        
        completed(cacheImage)
        return true
    }
    
    static private func loadFromUrl(url: String, completed: @escaping (UIImage?) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: URL(string: url)!) {
                let image = UIImage(data: data)
                ImageCache.getImageCache().set(forKey: url, image: image!)
                DispatchQueue.main.async {
                    completed(image)
                }
            } else {
                DispatchQueue.main.async {
                    completed(nil)
                }
            }
        }
    }
}
