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

    init(
        url: String,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        filterOptions: [ImageFilterOption] = []
    ) {
        asyncImageView = AsyncImageView(url: url, contentMode: contentMode, filterOptions: filterOptions)
        super.init(frame: .zero)
        addSubview(asyncImageView)
        setUpUI()
        asyncImageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setUpUI() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        minimumZoomScale = 0.5
        maximumZoomScale = 2
        alwaysBounceVertical = false
        alwaysBounceHorizontal = false
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

extension ZoomableAsyncImageView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        self.asyncImageView
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
