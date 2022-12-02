//
//  ImageSource.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/12/02.
//

import UIKit

import RxSwift

/// 특정 url의 이미지를 반환해주는 Image Source
protocol ImageSource {
    func fetchImage(of url: URL) -> Single<UIImage>
}

/// 특정 url의 이미지를 캐싱할 수 있는 Image Source
protocol CacheableImageSource: ImageSource {
    func saveToCache(for url: URL, _ image: UIImage)
}
