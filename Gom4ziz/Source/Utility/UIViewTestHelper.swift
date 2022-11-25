//
//  UIViewTestHelper.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/25.
//

#if DEBUG
import UIKit

extension SceneDelegate {

    // 하이라이트 텍스트뷰를 테스트할 수 있는 코드입니다
    func testHighlightedTextView() {
        let vc = UIViewController()
        let textView = HighlightedTextView(text: String.lorenIpsum)
        let scrollView: UIScrollView = UIScrollView()
        let superView = vc.view!
        superView.backgroundColor = .white
        superView.addSubview(scrollView)
        scrollView.addSubview(textView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.leftAnchor.constraint(equalTo: superView.leftAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor),
            scrollView.frameLayoutGuide.rightAnchor.constraint(equalTo: superView.rightAnchor),
            textView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            textView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            textView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor),
            textView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            textView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])

        changeRootViewController(vc)
    }
}
#endif

