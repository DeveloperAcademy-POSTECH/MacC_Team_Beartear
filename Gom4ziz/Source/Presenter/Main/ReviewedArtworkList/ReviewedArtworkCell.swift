//
//  ReviewedArtworkCell.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/27.
//

import UIKit

final class ReviewedArtworkCell: UITableViewCell {
    
    private var artworkImageView: AsyncImageView
    private let tiramisulCountLable = UILabel()
    private let questionLable = UILabel()
    private let answerLable = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        artworkImageView = AsyncImageView(
            url: "",
            contentMode: .scaleAspectFill)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setUpConstraints()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewModel(reviewedArtworkListCellViewModel: ReviewedArtworkListCellViewModel) {
        artworkImageView.changeURL(reviewedArtworkListCellViewModel.thumbnailImage)
        tiramisulCountLable.text = reviewedArtworkListCellViewModel.numberText
        questionLable.text = reviewedArtworkListCellViewModel.question
        answerLable.text = reviewedArtworkListCellViewModel.answer
        
    }
    
}

private extension ReviewedArtworkCell {
    func addSubviews() {
        addSubview(artworkImageView)
        addSubview(tiramisulCountLable)
        addSubview(questionLable)
        addSubview(answerLable)
    }
    
    func setUpConstraints() {
        setUpArtworkImageViewConstaints()
        setUpTiramisulCountLableConstaints()
        setUpQuestionLableConstaints()
        setUpAnswerLableConstaints()
    }
    
    func setUpUI() {
        setUpArtworkImageView()
        setUpTiramisulCountLable()
        setUpQuestionLable()
        setUpAnswerLable()
    }
}

// MARK: - 오토레이아웃 제약조건 설정
private extension ReviewedArtworkCell {
    func setUpArtworkImageViewConstaints() {
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artworkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            artworkImageView.heightAnchor.constraint(equalToConstant: 120),
            artworkImageView.widthAnchor.constraint(equalToConstant: 90),
            artworkImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        ])
    }
    
    func setUpTiramisulCountLableConstaints() {
        tiramisulCountLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tiramisulCountLable.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            tiramisulCountLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tiramisulCountLable.trailingAnchor.constraint(equalTo: artworkImageView.leadingAnchor, constant: -16)
        ])
    }
    
    func setUpQuestionLableConstaints() {
        questionLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLable.topAnchor.constraint(equalTo: tiramisulCountLable.bottomAnchor, constant: 10),
            questionLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            questionLable.trailingAnchor.constraint(equalTo: artworkImageView.leadingAnchor, constant: -16)
        ])
    }
    
    func setUpAnswerLableConstaints() {
        answerLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerLable.topAnchor.constraint(equalTo: questionLable.bottomAnchor, constant: 10),
            answerLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            answerLable.trailingAnchor.constraint(equalTo: artworkImageView.leadingAnchor, constant: -16),
            artworkImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - UI 설정
private extension ReviewedArtworkCell {
    
    func setUpArtworkImageView() {
        artworkImageView.layer.cornerRadius = 8
        artworkImageView.clipsToBounds = true
    }
    
    func setUpTiramisulCountLable() {
        tiramisulCountLable.numberOfLines = 0
        tiramisulCountLable.textStyle(.Caption, lineHeightMultiple: 1.5, .gray3)
    }
    
    func setUpQuestionLable() {
        questionLable.numberOfLines = 2
        questionLable.textStyle(.Headline1, lineHeightMultiple: 1.4, .gray4)
    }
    
    func setUpAnswerLable() {
        answerLable.numberOfLines = 2
        answerLable.textStyle(.Body2, lineHeightMultiple: 1.5, .gray3)
    }
}
