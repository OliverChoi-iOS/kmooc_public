//
//  ImageCache.swift
//  KMOOC
//
//  Created by MacBook on 2022/04/06.
//

import Foundation
import UIKit

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
    
    func remove(forKey: String) {
        cache.removeObject(forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache: ImageCache? = nil
    static func getImageCache() -> ImageCache {
        if imageCache != nil {
            return imageCache!
        } else {
            imageCache = ImageCache()
            return imageCache!
        }
    }
}
