//
//  ArtworkIntroductionView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/27.
//

import UIKit

final class ArtworkIntroductionView: BaseAutoLayoutUIView {

    private let artwork: Artwork
    private let artworkDescription: ArtworkDescription
    private let artworkImage: ZoomableAsyncImageView
    private var artworkModal: ArtworkIntroductionModal!
    private var isInitiated: Bool = false

    init(
        _ artwork: Artwork,
        _ artworkDescription: ArtworkDescription
    ) {
        self.artwork = artwork
        self.artworkDescription = artworkDescription
        artworkImage = ZoomableAsyncImageView(url: artwork.imageUrl, contentMode: .scaleAspectFit)
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addArtworkInfoModal()
    }
}

extension ArtworkIntroductionView {

    func addSubviews() {
        addSubviews(artworkImage)
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
            artworkImage.heightAnchor.constraint(equalTo: artworkImage.widthAnchor, multiplier: 1.487),
            artworkImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            artworkImage.topAnchor.constraint(equalTo: topAnchor)
        ])
    }

}

private extension ArtworkIntroductionView {

    func addArtworkInfoModal() {
        if !isInitiated {
            isInitiated = true
            let modalFrame: CGRect = CGRect(x: frame.minX, y: artworkImage.frame.maxY, width: frame.width, height: frame.height)
            artworkModal = ArtworkIntroductionModal(frame: modalFrame, artwork: artwork, descrption: artworkDescription)
            addSubview(artworkModal)
        }
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
