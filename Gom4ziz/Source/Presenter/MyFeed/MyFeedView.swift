//
//  MyFeedView.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/23.
//

import UIKit

final class MyFeedView: BaseAutoLayoutUIView {
    
    private let artwork: Artwork
    private let questionAnswer: QuestionAnswer
    
    // MARK: - UI Component
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // N번째 티라미술
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = artwork.question
        label.numberOfLines = 0
        label.textStyle(.Display2, .blackFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var questionAnswerSectionTitleView = SectionTitleView(title: "나의 생각")
    
    private lazy var questionAnswerLabel: UILabel = {
        let label = UILabel()
        label.text = questionAnswer.questionAnswer
        label.numberOfLines = 0
        label.textStyle(.Body1, .blackFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var questionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [questionAnswerSectionTitleView,
                                                      questionAnswerLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // 작품 정보
    
    private lazy var artworkImageView: AsyncImageView = .init(
        url: artwork.imageUrl,
        contentMode: .scaleAspectFill,
        filterOptions: [
            .contrast(1.2),
            .exposure(0.3)
        ])
    
    private lazy var artworkTitleLabel: UILabel = {
        let label = UILabel()
        label.text = artwork.title
        label.numberOfLines = 0
        label.textStyle(.Title, .blackFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var artworkArtistLabel: UILabel = {
        let label = UILabel()
        label.text = artwork.artist
        label.numberOfLines = 0
        label.textStyle(.Body2, .gray4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var artworkInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [artworkTitleLabel,
                                                      artworkArtistLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var artworkStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [artworkImageView,
                                                       artworkInfoStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // 작품 소개
    
    private lazy var artworkDesciptionSectionTitleView: SectionTitleView = .init(title: "작품 소개")
    
    lazy var highlightTextView: HighlightedTextView = HighlightedTextView(text: " ", highlights: [], isEditable: false, isExpandable: false)
    
    private lazy var artworkDescriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [artworkDesciptionSectionTitleView,
                                                       highlightTextView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // 나의 감상
    
    private lazy var reviewSectionTitleView: SectionTitleView = .init(title: "나의 감상")
    
    lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textStyle(.Body1, .blackFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var reviewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewSectionTitleView,
                                                       reviewLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var myFeedStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [questionLabel,
                                                       questionStackView,
                                                       artworkStackView,
                                                       artworkDescriptionStackView,
                                                       reviewStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(artwork: Artwork,
         questionAnswer: QuestionAnswer) {
        self.artwork = artwork
        self.questionAnswer = questionAnswer
        super.init(frame: .zero)
        self.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MyFeedView {
    
    func addSubviews() {
        self.addSubview(scrollView)
        scrollView.addSubview(myFeedStackView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            
            myFeedStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            myFeedStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -80),
            myFeedStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            myFeedStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            myFeedStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            questionLabel.topAnchor.constraint(equalTo: myFeedStackView.topAnchor, constant: 12),
            questionLabel.leftAnchor.constraint(equalTo: myFeedStackView.leftAnchor, constant: 16),
            questionLabel.rightAnchor.constraint(equalTo: myFeedStackView.rightAnchor, constant: -16),

            questionStackView.leftAnchor.constraint(equalTo: myFeedStackView.leftAnchor, constant: 16),
            questionStackView.rightAnchor.constraint(equalTo: myFeedStackView.rightAnchor, constant: -16),
            
            artworkStackView.leftAnchor.constraint(equalTo: myFeedStackView.leftAnchor),
            artworkStackView.rightAnchor.constraint(equalTo: myFeedStackView.rightAnchor),
            artworkImageView.widthAnchor.constraint(equalTo: myFeedStackView.widthAnchor),

            artworkDescriptionStackView.leftAnchor.constraint(equalTo: myFeedStackView.leftAnchor, constant: 16),
            artworkDescriptionStackView.rightAnchor.constraint(equalTo: myFeedStackView.rightAnchor, constant: -16),
            
            reviewStackView.leftAnchor.constraint(equalTo: myFeedStackView.leftAnchor, constant: 16),
            reviewStackView.rightAnchor.constraint(equalTo: myFeedStackView.rightAnchor, constant: -16),
            reviewStackView.bottomAnchor.constraint(equalTo: myFeedStackView.bottomAnchor)
        ])
    }
    
    func setUpUI() {

    }
    
}

#if DEBUG
import SwiftUI
struct MyFeedViewPreview: PreviewProvider {
    static var previews: some View {
        MyFeedView(artwork: .mockData,
                   questionAnswer: .mockData)
            .toPreview()
    }
}
#endif
