//
//  AsyncImage.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/23.
//

import UIKit

import RxSwift

final class AsyncImageView: UIImageView {

    private var url: String
    private var errorIndicator: UIButton?
    private let progressView: UIView
    private let filterOptions: [ImageFilterOption]
    private var previousDisposable: Disposable?
    private let asyncImageManager: AsyncImageManager = .shared

    init(
        url string: String,
        progressView: UIView = UIActivityIndicatorView(style: .large),
        contentMode: ContentMode = .scaleAspectFill,
        filterOptions: [ImageFilterOption] = []
    ) {
        self.url = string
        self.filterOptions = filterOptions
        self.progressView = progressView
        super.init(frame: .zero)
        self.contentMode = contentMode
        self.isUserInteractionEnabled = true
        loadImageFromURL()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - 퍼블릭 API
extension AsyncImageView {

    func changeURL(_ url: URL) {
        self.url = url.absoluteString
        loadImageFromURL()
    }

    func changeURL(_ url: String) {
        self.url = url
        loadImageFromURL()
    }

}

// MARK: - 내부구현
private extension AsyncImageView {

    func addIndicator() {
        guard progressView.superview == nil else { return }
        addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: topAnchor),
            progressView.leftAnchor.constraint(equalTo: leftAnchor),
            progressView.rightAnchor.constraint(equalTo: rightAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        if let indicator = progressView as? UIActivityIndicatorView {
            indicator.startAnimating()
        }
    }

    func addErrorIndicator(_ error: Error) {
        errorIndicator = UIButton()
        var configuration: UIButton.Configuration = .filled()
        configuration.background.backgroundColor = .red
        configuration.title = "다시 시도"
        configuration.image = UIImage(systemName: "wifi.exclamationmark")
        errorIndicator!.configuration = configuration
        addSubview(errorIndicator!)
        errorIndicator!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorIndicator!.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorIndicator!.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        errorIndicator!.addTarget(self, action: #selector(loadImageFromURL), for: .touchUpInside)
    }

    @objc func loadImageFromURL() {
        previousDisposable?.dispose()
        startLoading()
        removeErrorView()
        previousDisposable = asyncImageManager
            .loadImage(url: url, filterOptions: filterOptions)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] image in
                guard let self else { return }
                self.removeProgressView()
                self.image = image
            }, onFailure: { [weak self] error in
                guard let self else { return }
                self.removeProgressView()
                self.addErrorIndicator(error)
            })
    }

    func removeProgressView() {
        progressView.removeFromSuperview()
    }

    func removeErrorView() {
        errorIndicator?.removeFromSuperview()
        errorIndicator = nil
    }

    func startLoading() {
        addIndicator()
    }
}

#if DEBUG
import SwiftUI
struct AsyncImageViewPreview: PreviewProvider {
    static var previews: some View {
        Group {
            AsyncImageView(url: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/440px-Image_created_with_a_mobile_phone.png").toPreview()
            AsyncImageView(url: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/440px-Image_created_with_a_mobile_phone.png", contentMode: .scaleAspectFit).toPreview()
            AsyncImageView(url: "https://wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/440px-Image_created_with_a_mobile_phone.png", contentMode: .scaleAspectFit).toPreview()
        }
    }
}
#endif
