//
//  ImageCacheManager.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/23.
//

import UIKit

import RxSwift

public final class AsyncImageManager {

    public static let shared: AsyncImageManager = AsyncImageManager()
    private let session: URLSession = URLSession(configuration: .ephemeral)
    private let inMemorySource: some CacheableImageSource = InMemoryImageSource.shared
    private let diskSource: some CacheableImageSource = DiskImageSource()
    private let networkSource: some ImageSource = NetworkImageSource()

    private init() { }

    func loadImage(
        url: URL,
        filterOptions: [ImageFilterOption]
    ) -> Single<UIImage> {
        inMemorySource
            .fetchImage(of: url)
            .catch { [diskSource, inMemorySource] _ -> Single<UIImage> in
                // 디스크 소스에서 불러오기에 성공했다면, 인메모리소스에 저장해야함
                diskSource.fetchImage(of: url)
                    .do(onSuccess: {
                        inMemorySource.saveToCache(for: url, $0)
                    })
            }
            .catch { [networkSource, diskSource, inMemorySource] _ -> Single<UIImage> in
                // 네트워크 소스에서 불러오기에 성공했다면, 인메모리 소스, 디스크 소스에 동시에 저장함
                networkSource.fetchImage(of: url)
                    .do(onSuccess: {
                        inMemorySource.saveToCache(for: url, $0)
                        diskSource.saveToCache(for: url, $0)
                    })
            }
            .map { image in
                guard let image = image.setFilters(filterOptions: filterOptions) else {
                    throw RxError.unknown
                }
                return image
            }
            // 모든 작업은 백그라운드 쓰레드에서 이루어진다.
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
    }

    func loadImage(
        url string: String,
        filterOptions: [ImageFilterOption]
    ) -> Single<UIImage> {

        guard let url: URL = URL(string: string) else {
            return Single.error(URLError(.badURL))
        }
        return loadImage(url: url, filterOptions: filterOptions)
    }

}
