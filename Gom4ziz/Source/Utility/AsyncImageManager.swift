//
//  ImageCacheManager.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/23.
//

import UIKit

public final class AsyncImageManager {

    enum Option: Equatable {
        case useCache
        case onlyRemote

        static func == (lhs: Option, rhs: Option) -> Bool {
            switch (lhs, rhs) {
            case (.useCache, .useCache): return true
            case (.onlyRemote, .onlyRemote): return true
            default: return false
            }
        }
    }

    public static let shared: AsyncImageManager = AsyncImageManager()
    private let session: URLSession = URLSession(configuration: .ephemeral)
    private init() { }

    func loadImage(url: URL,
                   option: Option = .useCache,
                   filterOptions: [ImageFilterOption],
                   completion: @escaping (UIImage?, Error?) -> Void) {
        // 디스크 캐시에 image 데이터가 있으면, 바로 함수를 종료한다.

        if option == .useCache, let image = loadFromDisk(url: url.absoluteString)?.setFilters(filterOptions: filterOptions) {

            completion(image, nil)
            return
        }

        let request: URLRequest = URLRequest(url: url, timeoutInterval: 5)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(nil, error!)
                return
            }
            guard let data, let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(nil, URLError(.badServerResponse))
                return
            }

            guard let image = UIImage(data: data)?.setFilters(filterOptions: filterOptions) else {
                completion(nil, URLError(.badServerResponse))
                return
            }
            // url에서 데이터를 반환했으면, 디스크 캐시에 저장한 후 종료
            self.saveToDisk(url: url.absoluteString, data: data)
            completion(image, nil)
        }.resume()
    }

    func loadImage(url string: String,
                   option: Option = .useCache,
                   filterOptions: [ImageFilterOption],
                   completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url: URL = URL(string: string) else {
            completion(nil, URLError(.badURL))
            return
        }
        loadImage(url: url, option: option, filterOptions: filterOptions, completion: completion)
    }
}

private extension AsyncImageManager {

    func loadFromDisk(url string: String) -> UIImage? {
        guard let cachePath = FileManager.cachePath else {
            return nil
        }
        let imagePath: URL = cachePath.appendingPathComponent(string.withoutPunctuations, isDirectory: false)

        guard let data = try? Data(contentsOf: imagePath), let image = UIImage(data: data) else {
            return nil
        }
        return image
    }

    func saveToDisk(url string: String, data: Data) {
        guard let cachePath = FileManager.cachePath else {
            return
        }
        let imagePath: URL = cachePath.appendingPathComponent(string.withoutPunctuations, isDirectory: false)

        try? data.write(to: imagePath, options: .atomic)
    }

}


