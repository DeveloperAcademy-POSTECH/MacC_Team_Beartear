//
//  HighlightedTextView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/22.
//

import UIKit

final class HighlightedTextView: BaseAutoLayoutUIView {
    var highlights: [Highlight] {
        didSet {
            selectedHighlightIndex = -1
            highlightText()
        }
    }
    private var selectedHighlightIndex: Int = -1
    private var isExpanded: Bool = false
    private let isExpandable: Bool
    private let text: String
    private let highlightColor: UIColor
    private let highlightTextColor: UIColor
    private let textView: UITextView = UITextView()
    private let addButton: UIButton = UIButton()
    private let toggleButton: UILabel = UILabel()
    private let deleteButton: BubbleButton = BubbleButton(text: "삭제")
    private let isEditable: Bool
    var onToggled: (() -> Void)?

    /// 하이라이트 칠 수 있는 텍스트 뷰입니다.
    /// - Parameters:
    ///   - text: 보여줄 텍스트
    ///   - highlights: 텍스트의 하이라이트들
    ///   - isEditable: 하이라이트를 편집할 수 있는지
    ///   - isExpandable: 텍스트가 너무 길면, 텍스트뷰를 짧게 혹은 길게 볼 수 있는지 (토글 버튼 활성화)
    ///   - highlightColor: 하이라이트의 백그라운드 컬러
    ///   - highlightTextColor: 하이라이트의 텍스트 컬러
    init(
        text: String = "",
        highlights: [Highlight] = [],
        isEditable: Bool = true,
        isExpandable: Bool = true,
        highlightColor: UIColor = .highlight,
        highlightTextColor: UIColor = .black
    ) {
        self.text = text
        self.isExpandable = isExpandable
        self.isEditable = isEditable
        self.highlightColor = highlightColor
        self.highlightTextColor = highlightTextColor
        self.highlights = highlights
        super.init(frame: .zero)
        highlightText()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - UIView 설정 관련 코드
extension HighlightedTextView {

    func addSubviews() {
        addSubview(textView)
        // 편집 가능할 때만 추가, 삭제 버튼을 추가한다.
        if isEditable {
            addSubview(addButton)
            addSubview(deleteButton)
        }
        // 확장가능할 때만 확장 버튼을 추가한다.
        if isExpandable {
            addSubview(toggleButton)
        }
    }

    func setUpConstraints() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leftAnchor.constraint(equalTo: leftAnchor),
            textView.rightAnchor.constraint(equalTo: rightAnchor),
            textView.topAnchor.constraint(equalTo: topAnchor)
        ])

        // 확장 가능할 때만 토글 버튼의 제약조건을 설정한다.
        if isExpandable {
            toggleButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                toggleButton.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
                toggleButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 4),
                toggleButton.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }

    func setUpUI() {
        setUpTextView()
        setUpSelf()
        // 편집가능할 때만 추가, 삭제버튼을 설정한다.
        if isEditable {
            setUpAddButton()
            setUpDeleteButton()
            hideDeleteButton()
        }
        // 확장 가능할 때만 toggle button을 세팅한다!
        if isExpandable {
            setUpToggleButton()
        }
    }

}

// MARK: - UITextView Delegate
extension HighlightedTextView: UITextViewDelegate {

    /// 유저가 텍스트뷰의 텍스트를 선택할 때마다 호출되는 함수
    /// (주의) 또한 이 함수는, attributedText가 변경될 때마다 호출되는 것으로 보입니다. 따라서 단순히 텍스트를 세팅했을 때랑, 유저가 실제로 text를 선택했을 때를 구분해서 사용해야 할 것으로 보입니다.
    /// - Parameter textView: 텍스트뷰
    func textViewDidChangeSelection(_ textView: UITextView) {
        // 만약 유저가 text selection을 해제했으면, 추가버튼과 메뉴를 숨긴다.
        guard let range = textView.selectedTextRange else {
            hideAddButton()
            selectedHighlightIndex = -1
            UIMenuController.shared.hideMenu()
            return
        }
        showAddButton(at: range.end)
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        // 편집 가능해야만, 하이라이트를 선택할 수 있다.
        guard isEditable else {
            return false
        }
        changeSelectedHighlight(of: characterRange)
        showDeleteButton(range: characterRange)
        return false
    }
}

// MARK: - 하이라이트 추가/ 삭제 관련 구현들입니다.
private extension HighlightedTextView {

    func hideAddButton() {
        addButton.layer.opacity = 0
        addButton.isEnabled = false
    }

    /// 유저가 텍스트를 선택할 경우, 적절한 위치에 하이라이트 추가 버튼을 띄운다.
    /// - Parameter position: 커서의 마지막 위치
    func showAddButton(at position: UITextPosition) {
        let cursorLocation: CGRect = textView.caretRect(for: position)
        let dx: CGFloat
        if cursorLocation.minX < 20 {
            dx = 40
        } else if cursorLocation.minX > (frame.width - 80) {
            dx = -40
        } else {
            dx = 20
        }
        addButton.layer.opacity = 1
        addButton.isEnabled = true
        addButton.center = CGPointMake(cursorLocation.minX + dx, cursorLocation.minY + 60)
    }

    @objc func onAddButtonClick(sender: UIButton) {
        guard let range = textView.selectedTextRange else {
            return
        }
        let start = getIntIndexOfTextPosition(range.start)
        let end = getIntIndexOfTextPosition(range.end)
        var appended: [Highlight] = highlights
        appended.append(Highlight(start: start, end: end))
        highlights = HighlightProcessor().processHighlights(appended)
        textView.selectedTextRange = nil
        hideAddButton()
    }

    func changeSelectedHighlight(of range: NSRange) {
        guard let index = highlights.firstIndex(where: {
            $0.range == range
        }) else {
            selectedHighlightIndex = -1
            return
        }
        selectedHighlightIndex = index
    }

    func showDeleteButton(range: NSRange) {
        // 먼저 선택된 하이라이트의 Rectangle을 구한다.
        guard let start: UITextPosition = textView.position(from: textView.beginningOfDocument, offset: range.location) else {
            return
        }
        let startCGRect: CGRect = textView.caretRect(for: start)

        let startX: CGFloat
        if startCGRect.minX < 30 {
            startX = startCGRect.minX + 15
        } else {
            startX = startCGRect.minX
        }

        deleteButton.center = CGPoint(x: startX, y: startCGRect.minY - 20)
        deleteButton.layer.opacity = 1
        deleteButton.isEnabled = true
    }

    func hideDeleteButton() {
        deleteButton.layer.opacity = 0
        deleteButton.isEnabled = false
    }

    @objc func deleteHighlight() {
        // 하이라이트가 선택되있을 때만 작동함!
        guard selectedHighlightIndex != -1 && highlights.count > selectedHighlightIndex else {
            return
        }
        _ = highlights.remove(at: selectedHighlightIndex)
        hideDeleteButton()
    }
}

// MARK: - Highlight 표시 관련 코드입니다
private extension HighlightedTextView {

    func highlightText() {
        let willSet: NSMutableAttributedString = .init(attributedString: textView.attributedText)
        hideHighlights(willSet)
        for highlight in highlights {
            showHighlight(willSet, range: highlight.range)
        }
        textView.attributedText = willSet
        textView.selectedTextRange = nil
    }

    func hideHighlights(_ text: NSMutableAttributedString) {
        text.removeAttribute(.link, range: NSRange(location: 0, length: text.length - 1))
    }

    func showHighlight(_ text: NSMutableAttributedString, range: NSRange) {
        text.addAttribute(.link, value: "\(range.location)\(range.length)", range: range)
    }

}

// MARK: - 내부 구현
private extension HighlightedTextView {

    func getIntIndexOfTextPosition(_ textPosition: UITextPosition) -> Int {
        textView.offset(from: textView.beginningOfDocument, to: textPosition)
    }

    @objc func toggleExpand(sender: Any) {
        if isExpanded {
            toggleButton.text = "더보기"
            textView.textContainer.maximumNumberOfLines = 3
            textView.invalidateIntrinsicContentSize()
        } else {
            toggleButton.text = "간단히"
            textView.textContainer.maximumNumberOfLines = 0
            textView.invalidateIntrinsicContentSize()
        }
        hideDeleteButton()
        hideAddButton()
        isExpanded.toggle()
        onToggled?()
    }
}

// MARK: - UI 설정
private extension HighlightedTextView {

    func setUpSelf() {
        backgroundColor = .clear
    }

    func setUpDeleteButton() {
        deleteButton.sizeToFit()
        deleteButton.addTarget(self, action: #selector(deleteHighlight), for: .touchUpInside)
    }

    func setUpToggleButton() {
        toggleButton.text = "더보기"
        toggleButton.font = .systemFont(ofSize: 14, weight: .regular)
        toggleButton.textColor = .primary
        toggleButton.isUserInteractionEnabled = true
        let tapGestureRecognzier: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleExpand(sender: )))
        toggleButton.addGestureRecognizer(tapGestureRecognzier)
    }

    func setUpTextView() {
        textView.text = text
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = isEditable
        textView.delegate = self
        textView.backgroundColor = .clear
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        textView.textStyle(.Body1, .gray4)
        textView.linkTextAttributes = [
            .backgroundColor: highlightColor,
            .foregroundColor: highlightTextColor
        ]
        // 확장 가능할 때는 초반에 3줄로 설정함
        if isExpandable {
            textView.textContainer.maximumNumberOfLines = 3
        }
        // 확장 불가능 할 때는 처음부터 다 보여줌
        else {
            textView.textContainer.maximumNumberOfLines = 0
        }
    }

    func setUpAddButton() {
        var configuration: UIButton.Configuration = .filled()
        configuration.image = UIImage(named: "addButton")
        configuration.background.backgroundColor = .clear
        configuration.contentInsets = .zero
        addButton.configuration = configuration
        addButton.layer.opacity = 0
        addButton.sizeToFit()
        addButton.imageView?.layer.shadowColor = UIColor.black.cgColor
        addButton.imageView?.layer.shadowOpacity = 0.35
        addButton.imageView?.layer.shadowRadius = 2.5
        addButton.imageView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        addButton.addTarget(self, action: #selector(onAddButtonClick(sender: )), for: .touchUpInside)
    }
}

#if DEBUG
import SwiftUI
struct HighlightedTextViewPreview: PreviewProvider {
    static var previews: some View {
        
        HighlightedTextView(text: String(String.lorenIpsum))
            .toPreview()
            .padding()
            .previewDisplayName("다 되는 텍스트뷰")

        HighlightedTextView(text: String(String.lorenIpsum.dropLast(600)), isExpandable: false)
            .toPreview()
            .padding()
            .previewDisplayName("확장 안되는 텍스트뷰")

        HighlightedTextView(text: String(String.lorenIpsum.dropLast(600)), isEditable: false)
            .toPreview()
            .padding()
            .previewDisplayName("편집 안되는 텍스트뷰")
    }
}
#endif
