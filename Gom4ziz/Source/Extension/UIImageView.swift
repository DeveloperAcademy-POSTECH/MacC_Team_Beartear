//
//  UIImageView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/23.
//

import UIKit

extension UIImageView {

    func loadImage(url: URL,
                   filterOptions: [ImageFilterOption] = [],
                   completion: ((Error?) -> Void)? = nil) {
        AsyncImageManager.shared.loadImage(url: url, filterOptions: filterOptions) { image, error in
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

    func loadImage(url string: String,
                   filterOptions: [ImageFilterOption] = [],
                   completion: ((Error?) -> Void)? = nil) {
        guard let url = URL(string: string) else {
            completion?(URLError(URLError.badURL))
            return
        }
        loadImage(url: url, filterOptions: filterOptions, completion: completion)
    }

}
