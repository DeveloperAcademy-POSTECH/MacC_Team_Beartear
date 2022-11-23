//
//  UIImageView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/23.
//

import UIKit

extension UIImageView {

    func loadImage(url: URL, option: NetworkImageCacheManager.Option = .useCache, completion: ((Error?) -> Void)? = nil) {
        NetworkImageCacheManager.shared.loadImage(url: url, option: option) { image, error in
            DispatchQueue.main.async {
                guard error == nil, let image else {
                    completion?(error)
                    return
                }
                self.image = image
                completion?(nil)
            }
        }
    }

    func loadImage(url string: String, option: NetworkImageCacheManager.Option = .useCache, completion: ((Error?) -> Void)? = nil) {
        guard let url = URL(string: string) else {
            return
        }
        loadImage(url: url, option: option, completion: completion)
    }

}
