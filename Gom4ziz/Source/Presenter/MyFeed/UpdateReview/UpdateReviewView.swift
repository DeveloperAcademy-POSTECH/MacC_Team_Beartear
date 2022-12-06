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
        self.addSubview(scrollView)
        scrollView.addSubview(questionLabel)
        scrollView.addSubview(myAnswerSectionTitleView)
        scrollView.addSubview(myAnswerInputTextView)
        scrollView.addSubview(myReviewSectionTitleView)
        scrollView.addSubview(myReviewInputTextView)
    }
    
    func setUpConstraints() {
        myAnswerSectionTitleView.translatesAutoresizingMaskIntoConstraints = false
        myAnswerInputTextView.translatesAutoresizingMaskIntoConstraints = false
        myReviewSectionTitleView.translatesAutoresizingMaskIntoConstraints = false
        myReviewInputTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.keyboardLayoutGuide.topAnchor, constant: -16),
            
            questionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            questionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            questionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            myAnswerSectionTitleView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            myAnswerSectionTitleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            myAnswerSectionTitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            myAnswerInputTextView.topAnchor.constraint(equalTo: myAnswerSectionTitleView.bottomAnchor, constant: 20),
            myAnswerInputTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            myAnswerInputTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            myAnswerInputTextView.heightAnchor.constraint(equalToConstant: 240),
            
            myReviewSectionTitleView.topAnchor.constraint(equalTo: myAnswerInputTextView.bottomAnchor, constant: 40),
            myReviewSectionTitleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            myReviewSectionTitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            myReviewInputTextView.topAnchor.constraint(equalTo: myReviewSectionTitleView.bottomAnchor, constant: 20),
            myReviewInputTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            myReviewInputTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            myReviewInputTextView.heightAnchor.constraint(equalToConstant: 240),
            myReviewInputTextView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -16)
        ])
    }
    
    func setUpUI() {
        self.backgroundColor = .white
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:))))
    }
    
}

private extension UpdateReviewView {

    /// 유저가 화면을 탭할 경우, 키보드를 숨깁니다.
    /// - Parameter sender: 제스쳐 식별기
    @objc func handleTapGesture(sender: UITapGestureRecognizer) {
        if myAnswerInputTextView.canResignFirstResponder {
            _ = myAnswerInputTextView.resignFirstResponder()
        }
        
        if myReviewInputTextView.canResignFirstResponder {
            _ = myReviewInputTextView.resignFirstResponder()
        }
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
