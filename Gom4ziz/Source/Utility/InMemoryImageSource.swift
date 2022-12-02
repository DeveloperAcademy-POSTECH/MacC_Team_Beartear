//
//  InMemoryImageSource.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/12/02.
//

import UIKit

import RxSwift

final class InMemoryImageSource: CacheableImageSource {

    static let shared: some CacheableImageSource = InMemoryImageSource()
    private let cache: NSCache<NSString, UIImage> = NSCache()

    private init() { }

    func fetchImage(of url: URL) -> Single<UIImage> {
        let cacheKey: NSString = NSString(string: url.absoluteString)

        return Single.create { [cache] single -> Disposable in
            guard let cachedImage = cache.object(forKey: cacheKey) else {
                single(.failure(RxError.unknown))
                return Disposables.create()
            }
            single(.success(cachedImage))
            return Disposables.create()
        }
    }

    func saveToCache(for url: URL, _ image: UIImage) {
        let cacheKey: NSString = NSString(string: url.absoluteString)
        cache.setObject(image, forKey: cacheKey)
    }

}
