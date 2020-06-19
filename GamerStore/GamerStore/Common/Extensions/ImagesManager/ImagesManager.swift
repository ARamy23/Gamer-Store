//
//  ImagesManager.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UIImage

class ImagesManager {
    private var cache: NSCache<NSString, UIImage> = NSCache()
    
    func getImage(from urlString: String, completionHandler: @escaping (UIImage?) -> ()) {
        if let image = cache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            guard let url = URL(string: urlString) else { return }
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let self = self else { return }
                if let data = try? Data(contentsOf: url) {
                    let img: UIImage! = UIImage(data: data)
                    self.cache.setObject(img, forKey: urlString as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img)
                    }
                }
            }
        }
    }
}
