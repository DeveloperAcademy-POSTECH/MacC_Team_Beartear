//
//  UpdateReviewView.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/12/02.
//

import UIKit

final class UpdateReviewView: BaseAutoLayoutUIView {
    
    private let question: String
    private let myAnswer: String
    private let myReview: String
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = question
        label.numberOfLines = 0
        label.textStyle(.Display2, .blackFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let myAnswerSectionTitleView = SectionTitleView(title: "나의 생각")
    lazy var myAnswerInputTextView = PlaceholderTextView(text: myAnswer)
    
    private let myReviewSectionTitleView = SectionTitleView(title: "나의 감상")
    lazy var myReviewInputTextView = PlaceholderTextView(text: myReview)
    
    init(question: String, myAnswer: String, myReview: String) {
        self.question = question
        self.myAnswer = myAnswer
        self.myReview = myReview
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UpdateReviewView {
    
    func addSubviews() {
        self.addSubview(questionLabel)
        self.addSubview(myAnswerSectionTitleView)
        self.addSubview(myAnswerInputTextView)
        self.addSubview(myReviewSectionTitleView)
        self.addSubview(myReviewInputTextView)
    }
    
    func setUpConstraints() {
        myAnswerSectionTitleView.translatesAutoresizingMaskIntoConstraints = false
        myAnswerInputTextView.translatesAutoresizingMaskIntoConstraints = false
        myReviewSectionTitleView.translatesAutoresizingMaskIntoConstraints = false
        myReviewInputTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            myAnswerSectionTitleView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            myAnswerSectionTitleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            myAnswerSectionTitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            myAnswerInputTextView.topAnchor.constraint(equalTo: myAnswerSectionTitleView.bottomAnchor, constant: 20),
            myAnswerInputTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            myAnswerInputTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            myAnswerInputTextView.heightAnchor.constraint(equalToConstant: 240),
            
            myReviewSectionTitleView.topAnchor.constraint(equalTo: myAnswerInputTextView.bottomAnchor, constant: 40),
            myReviewSectionTitleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            myReviewSectionTitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            myReviewInputTextView.topAnchor.constraint(equalTo: myReviewSectionTitleView.bottomAnchor, constant: 20),
            myReviewInputTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            myReviewInputTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            myReviewInputTextView.heightAnchor.constraint(equalToConstant: 240),
            myReviewInputTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    func setUpUI() {
        self.backgroundColor = .white
    }
    
}

#if DEBUG
import SwiftUI

struct UpdateReviewViewPreview: PreviewProvider {
    static var previews: some View {
        UpdateReviewView(question: Artwork.mockData.question, myAnswer: QuestionAnswer.mockData.questionAnswer, myReview: ArtworkReview.mockData.review)
            .toPreview()
    }
}
#endif
