//
//  ImageCache.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 7/17/19.
//  Copyright © 2019 Oleksandr Gribov. All rights reserved.
//

import UIKit

// Responsible for caching product images 
class ImageCache {
    let cache = NSCache<NSString,UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String ) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
