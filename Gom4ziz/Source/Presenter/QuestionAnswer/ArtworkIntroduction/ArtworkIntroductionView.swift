//
//  ArtworkIntroductionView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/27.
//

import UIKit

final class ArtworkIntroductionView: BaseAutoLayoutUIView {

    private let artworkImage: ZoomableAsyncImageView
    private let artworkModal: ArtworkIntroductionModal

    init(
        _ artwork: Artwork,
        _ artworkDescription: ArtworkDescription
    ) {
        artworkImage = ZoomableAsyncImageView(url: artwork.imageUrl, contentMode: .scaleAspectFill)
        artworkModal = ArtworkIntroductionModal(artwork: artwork, descrption: artworkDescription)
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ArtworkIntroductionView {

    func addSubviews() {
        addSubviews(artworkImage, artworkModal)
    }

    func setUpConstraints() {
        setUpArtworkImageConstraints()
    }

    func setUpUI() {
        backgroundColor = .gray1
    }

}

// MARK: - 제약조건 설정
private extension ArtworkIntroductionView {

    func setUpArtworkImageConstraints() {
        artworkImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artworkImage.widthAnchor.constraint(equalTo: widthAnchor),
            artworkImage.heightAnchor.constraint(equalTo: artworkImage.widthAnchor, multiplier: 1.33),
            artworkImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            artworkImage.topAnchor.constraint(equalTo: topAnchor)
        ])
    }

}

#if DEBUG
import SwiftUI
struct ArtworkIntroductionViewPreview: PreviewProvider {
    static var previews: some View {
        ArtworkIntroductionView(
            Artwork.mockData,
            ArtworkDescription.mockData
        ).toPreview()
    }
}
#endif
