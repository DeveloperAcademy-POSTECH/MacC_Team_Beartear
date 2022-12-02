//
//  DiskImageSource.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/12/02.
//

import UIKit

import RxSwift

struct DiskImageSource: CacheableImageSource {

    func fetchImage(of url: URL) -> Single<UIImage> {
        Single.create { single -> Disposable in

            guard let cachePath = FileManager.cachePath else {
                single(.failure(RxError.unknown))
                return Disposables.create()
            }

            let imagePath: URL = cachePath.appendingPathComponent(url.absoluteString.withoutPunctuations, isDirectory: false)

            guard let data = try? Data(contentsOf: imagePath), let image = UIImage(data: data) else {
                single(.failure(RxError.unknown))
                return Disposables.create()
            }
            single(.success(image))

            return Disposables.create()
        }
    }

    func saveToCache(for url: URL, _ image: UIImage) {
        guard let cachePath = FileManager.cachePath else {
            return
        }
        let imagePath: URL = cachePath.appendingPathComponent(url.absoluteString.withoutPunctuations, isDirectory: false)

        guard let pngData = image.pngData() else {
            return
        }

        try? pngData.write(to: imagePath, options: .atomic)
    }

}

extension FileManager {
    static var cachePath: URL? {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    }
}

extension String {
    var withoutPunctuations: String {
        return self.components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: "")
      }
}
