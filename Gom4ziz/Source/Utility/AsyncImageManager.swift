//
//  ImageCacheManager.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/23.
//

import UIKit

public final class AsyncImageManager {

    public static let shared: AsyncImageManager = AsyncImageManager()
    private let session: URLSession = URLSession(configuration: .ephemeral)
    private init() { }

    func loadImage(url: URL,
                   filterOptions: [ImageFilterOption],
                   completion: @escaping (UIImage?, Error?) -> Void) {
        // 디스크 캐시에 image 데이터가 있으면, 바로 함수를 종료한다.
    }

    func loadImage(url string: String,
                   filterOptions: [ImageFilterOption],
                   completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url: URL = URL(string: string) else {
            completion(nil, URLError(.badURL))
            return
        }
        loadImage(url: url, filterOptions: filterOptions, completion: completion)
    }
}
