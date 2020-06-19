//
//  ImagesManager.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UIImage
import Kingfisher

extension UIImageView {
    
    @discardableResult
    private func downloadImage(_ url: URL, _ placeholderImage: UIImage? = nil) -> DownloadTask? {
        kf.indicatorType = .activity
        kf.indicator?.startAnimatingView()
        return self.kf.setImage(with: url, placeholder: placeholderImage, options: [.transition(.fade(0.6))]) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let value):
                self.kf.indicator?.stopAnimatingView()
                self.image = value.image
            case .failure(let error):
                debugPrint(error.errorDescription ?? "Error")
            }
        }
    }
    
    func setImageWith(_ linkString: String?, _ placeholderImage: UIImage? = nil) {
        guard let linkString = linkString, let url = URL(string: linkString) else { return }
        downloadImage(url, placeholderImage)
    }
    
    func setImageWith(url: URL?, _ placeholderImage: UIImage? = nil) {
        guard let url = url else { return }
        downloadImage(url, placeholderImage)
    }
}
