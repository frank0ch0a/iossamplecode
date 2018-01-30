//
//  ImageCell.swift
//  El Comun
//
//  Created by Francisco Ochoa on 10/05/17.
//  Copyright © 2017 fochoa. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UInt64 {
    
    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }
    
}


class ImageCell: UICollectionViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    var categoryName:String? = nil
    @IBOutlet weak var imageView: UIImageView!
    
    
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )
    
    
    func retrieveImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request {
        return Alamofire.request(url, method: .get).responseImage { response in
            guard let image = response.result.value else { return }
            completion(image)
            self.cache(image, for: url)
        }
    }
    
    //MARK: - Image Caching
    
    func cache(_ image: Image, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }
    
    func cachedImage(for url: String) -> Image? {
        return imageCache.image(withIdentifier: url)
    }

}
