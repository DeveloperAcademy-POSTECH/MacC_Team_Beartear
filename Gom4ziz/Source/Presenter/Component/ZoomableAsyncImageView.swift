//
//  ZoomableAsyncImageView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/28.
//

import UIKit

final class ZoomableAsyncImageView: UIScrollView {

    private let asyncImageView: AsyncImageView
    private var isSizeDetermined: Bool = false
    private let maximumScale: CGFloat = 10
    private let minimumScale: CGFloat = 1

    init(
        url: String,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        filterOptions: [ImageFilterOption] = []
    ) {
        asyncImageView = AsyncImageView(url: url, contentMode: contentMode, filterOptions: filterOptions)
        super.init(frame: .zero)
        isScrollEnabled = false
        addSubview(asyncImageView)
        setUpUI()
        setUpDoubleTapGestureRecognizer()
        asyncImageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setUpUI() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        alwaysBounceVertical = true
        alwaysBounceHorizontal = true
        maximumZoomScale = maximumScale
        minimumZoomScale = minimumScale
        delegate = self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if !isSizeDetermined {
            isSizeDetermined = true
            asyncImageView.frame = bounds
        }
    }
}

// MARK: - 퍼블릭 API
extension ZoomableAsyncImageView {

    func changeURL(_ url: URL) {
        self.asyncImageView.changeURL(url)
    }

    func changeURL(_ url: String) {
        self.asyncImageView.changeURL(url)
    }

}

extension ZoomableAsyncImageView: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        self.asyncImageView
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if zoomScale > maximumScale {
            zoomScale = maximumScale
        } else if zoomScale < minimumScale {
            zoomScale = minimumScale
        }
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if zoomScale > minimumScale && !isScrollEnabled {
            isScrollEnabled.toggle()
            return
        } else if zoomScale == minimumScale && isScrollEnabled {
            isScrollEnabled.toggle()
        }
    }

}

// MARK: - 더블탭 제스처
private extension ZoomableAsyncImageView {

    func setUpDoubleTapGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
    }

    @objc func doubleTapped() {
        if zoomScale < 1.5 {
            setZoomScale(4, animated: true)
            return
        }
        setZoomScale(minimumScale, animated: true)
    }

}

#if DEBUG
import SwiftUI
struct ZoomableAsyncImageViewPreview: PreviewProvider {
    static var previews: some View {
        ZoomableAsyncImageView(url: Artwork.mockData.imageUrl)
            .toPreview()
            .frame(width: 300, height: 300, alignment: .center)
    }
}
#endif
