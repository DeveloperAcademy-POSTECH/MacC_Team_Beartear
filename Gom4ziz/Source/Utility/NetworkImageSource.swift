//
//  NetworkImageSource.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/12/02.
//

import UIKit

import RxSwift

struct NetworkImageSource: ImageSource {

    private let session: URLSession = URLSession(configuration: .ephemeral)

    func fetchImage(of url: URL) -> Single<UIImage> {
        let request: URLRequest = URLRequest(url: url, timeoutInterval: 10)
        return session
            .rx
            .data(request: request)
            .map {
                guard let image = UIImage(data: $0) else {
                    throw URLError(.badServerResponse)
                }
                return image
            }
            .asSingle()
    }

}
