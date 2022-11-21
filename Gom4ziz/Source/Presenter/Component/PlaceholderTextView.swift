//
//  PlaceholderTextView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/21.
//

import UIKit

/// Placeholder를 지정할 수 있는 TextView입니다.
final class PlaceholderTextView: UITextView {

    private let placeholder: UILabel = UILabel()
    private var textObservation: NSKeyValueObservation?

    /// PlaceholderTextView의 생성자
    /// - Parameters:
    ///   - placeholder: 플레이스 홀더로 사용할 텍스트입니다.
    ///   - text: textView에 들어갈 초기 텍스트입니다.
    init(
        placeholder: String? = nil,
        text: String? = nil
    ) {
        super.init(frame: .zero, textContainer: nil)
        self.placeholder.text = placeholder
        if let text, !text.isEmpty {
            self.text = text
            hidePlaceholder()
        }
        delegate = self
        addSubviews()
        setUpConstraints()
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}

// MARK: - TextView Delegate 설정부분
extension PlaceholderTextView: UITextViewDelegate {

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            showPlaceholder()
        } else {
            hidePlaceholder()
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        hidePlaceholder()
    }

}

// MARK: - UI 설정 부분
private extension PlaceholderTextView {

    func addSubviews() {
        addSubview(placeholder)
    }

    func setUpConstraints() {
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholder.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            placeholder.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
        ])
    }

    func setUpUI() {
        setUpTextView()
        setUpPlaceholder()
    }

    func setUpTextView() {
        layer.borderColor = UIColor.borderGray.cgColor
        layer.borderWidth = 1
        font = .systemFont(ofSize: 16, weight: .medium)
        textContainerInset = .init(top: 12, left: 7, bottom: 0, right: 0)
    }

    func setUpPlaceholder() {
        placeholder.textColor = .gray
        placeholder.font = .systemFont(ofSize: 16, weight: .medium)
    }

}

// MARK: - Private API
private extension PlaceholderTextView {
    /// 플레이스 홀더를 보여주는 함수
    func showPlaceholder() {
        placeholder.layer.opacity = 1
    }

    /// 플레이스 홀더를 숨기는 함수
    func hidePlaceholder() {
        placeholder.layer.opacity = 0
    }
}

// MARK: - 프리뷰
#if DEBUG
import SwiftUI
struct PlaceholderTextViewPreview: PreviewProvider {
    static var previews: some View {
        Group {
            PlaceholderTextView(
                placeholder: "플레이스홀더입니다.",
                text: "텍스트입니다."
            )
            .toPreview()
            .padding()
            PlaceholderTextView(
                placeholder: "플레이스홀더입니다.",
                text: ""
            )
            .toPreview()
            .padding()
        }
    }
}
#endif
