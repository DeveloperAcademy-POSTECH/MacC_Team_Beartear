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
    private let text: String
    private let highlightColor: UIColor
    private let highlightTextColor: UIColor
    private let scrollView: UIScrollView = UIScrollView()
    private let textView: UITextView = UITextView()
    private let addButton: UIButton = UIButton()
    private let isSelectable: Bool
    private let deleteMenuItem: UIMenuItem = UIMenuItem(title: "삭제", action: #selector(deleteHighlight))

    init(
        text: String = "",
        highlights: [Highlight] = [],
        isSelectable: Bool = true,
        highlightColor: UIColor = .highlight,
        highlightTextColor: UIColor = .black
    ) {
        self.text = text
        self.isSelectable = isSelectable
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

extension HighlightedTextView {

    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(textView)
        scrollView.addSubview(addButton)
    }

    func setUpConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: topAnchor),
            scrollView.frameLayoutGuide.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            textView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor),
            textView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            textView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            textView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    func setUpUI() {
        setUpAddButton()
        setUpTextView()
    }

}

// MARK: - UITextView Delegate
extension HighlightedTextView: UITextViewDelegate {

    /// 유저가 텍스트뷰의 텍스트를 선택할 때마다 호출되는 함수
    /// - Parameter textView: 텍스트뷰
    func textViewDidChangeSelection(_ textView: UITextView) {
        // 만약 유저가 text selection을 해제했으면, 추가버튼과 메뉴를 숨긴다.
        guard let range = textView.selectedTextRange else {
            hideAddButton()
            selectedHighlightIndex = -1
            UIMenuController.shared.hideMenu()

            return
        }
        onSelectionChanged(range: range)
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        guard isSelectable else {
            return false
        }
        textView.selectedRange = characterRange
        changeSelectedHighlight(of: characterRange)
        showHighlightSelectedMenu()
        return false
    }
}

// MARK: - 내부 구현
private extension HighlightedTextView {

    func changeSelectedHighlight(of range: NSRange) {
        guard let index = highlights.firstIndex(where: {
            $0.range == range
        }) else {
            selectedHighlightIndex = -1
            return
        }
        selectedHighlightIndex = index
    }

    func showHighlightSelectedMenu() {
        guard let range = textView.selectedTextRange else {
            return
        }
        let startCGRect: CGRect = textView.caretRect(for: range.start)
        let endCGRect: CGRect = textView.caretRect(for: range.end)

        let targetRect: CGRect = CGRectUnion(startCGRect, endCGRect)
        UIMenuController.shared.menuItems = [deleteMenuItem]
        UIMenuController.shared.showMenu(from: textView, rect: targetRect)
    }

    func onSelectionChanged(range: UITextRange) {
        showAddButton(at: range.end)
    }

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
        addButton.center = CGPointMake(cursorLocation.minX + dx, cursorLocation.minY + 50)
    }

    func highlightText() {
        let willSet: NSMutableAttributedString = .init(attributedString: textView.attributedText)
        hideHighlights(willSet)
        for highlight in highlights {
            addHighlight(willSet, range: highlight.range)
        }
        textView.attributedText = willSet
    }

    func hideHighlights(_ text: NSMutableAttributedString) {
        text.removeAttribute(.link, range: NSRange(location: 0, length: text.length - 1))
    }

    func addHighlight(_ text: NSMutableAttributedString, range: NSRange) {
        text.addAttribute(.link, value: "\(range.location)\(range.length)", range: range)
    }

    func getIntIndexOfTextPosition(_ textPosition: UITextPosition) -> Int {
        textView.offset(from: textView.beginningOfDocument, to: textPosition)
    }

    @objc func deleteHighlight() {
        // 하이라이트가 선택되있을 때만 작동함!
        guard selectedHighlightIndex != -1 && highlights.count > selectedHighlightIndex else {
            return
        }
        _ = highlights.remove(at: selectedHighlightIndex)
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
}

// MARK: - UI 설정
private extension HighlightedTextView {

    func setUpTextView() {
        textView.font = .systemFont(ofSize: 18, weight: .light)
        textView.text = text
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = isSelectable
        textView.delegate = self
        textView.linkTextAttributes = [
            .backgroundColor: highlightColor,
            .foregroundColor: highlightTextColor
        ]
    }

    func setUpAddButton() {
        var configuration: UIButton.Configuration = .filled()
        configuration.background.backgroundColor = UIColor.blue
        configuration.title = "Add"
        addButton.configuration = configuration
        addButton.layer.opacity = 0
        addButton.sizeToFit()
        addButton.addTarget(self, action: #selector(onAddButtonClick(sender: )), for: .touchUpInside)
    }

}

#if DEBUG
import SwiftUI
struct HighlightedTextViewPreview: PreviewProvider {
    static var previews: some View {
        Group {
            HighlightedTextView(text: String.lorenIpsum)
                .toPreview()
                .padding()

            HighlightedTextView(
                text: String.lorenIpsum,
                isSelectable: false
            )
                .toPreview()
                .padding()
        }
    }
}
#endif
