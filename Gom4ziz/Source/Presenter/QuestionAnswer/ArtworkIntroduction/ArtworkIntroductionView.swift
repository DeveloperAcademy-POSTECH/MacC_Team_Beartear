//
//  ArtworkIntroductionView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/27.
//

import UIKit

import RxCocoa

final class ArtworkIntroductionView: BaseAutoLayoutUIView {

    private let artwork: Artwork
    private let artworkDescription: ArtworkDescription
    private let artworkImage: ZoomableAsyncImageView
    private let artworkModal: ArtworkIntroductionModal
    private var isInitiated: Bool = false

    var review: ControlProperty<String> {
        artworkModal.text
    }

    var highlights: BehaviorRelay<[Highlight]> {
        artworkModal.highlights
    }

    init(
        artwork: Artwork,
        artworkDescription: ArtworkDescription,
        review: String,
        highlights: [Highlight]
    ) {
        self.artwork = artwork
        self.artworkDescription = artworkDescription
        artworkImage = ZoomableAsyncImageView(url: artwork.imageUrl, contentMode: .scaleAspectFit)
        artworkModal = ArtworkIntroductionModal(
            artwork: artwork,
            descrption: artworkDescription,
            review: review,
            highlights: highlights
        )
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
        addSubviews(artworkImage, artworkModal)
    }

    func setUpConstraints() {
        setUpArtworkImageConstraints()
    }

    func setUpUI() {
        backgroundColor = .white
    }

    func hideKeyboard() {
        artworkModal.hideKeyboard()
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
            artworkImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
    }

}

// MARK: - 모달의 frame을 재조정
private extension ArtworkIntroductionView {

    func addArtworkInfoModal() {
        if !isInitiated {
            isInitiated = true
            let modalFrame: CGRect = CGRect(x: frame.minX, y: artworkImage.frame.maxY, width: frame.width, height: frame.height - topBarHeight)
            artworkModal.setFrame(modalFrame)
            artworkModal.setTopY(topBarHeight)
        }
    }

}

#if DEBUG
import SwiftUI
struct ArtworkIntroductionViewPreview: PreviewProvider {
    static var previews: some View {
        ArtworkIntroductionView(
            artwork: Artwork.mockData,
            artworkDescription: ArtworkDescription.mockData,
            review: String.lorenIpsum,
            highlights: Highlight.mockData
        ).toPreview()
    }
}
#endif
