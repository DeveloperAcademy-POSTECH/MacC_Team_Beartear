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

    // 작품 소개 modal을 테스트할 수 있는 코드입니다.
    func testArtworkIntroductionModal() {
        let vc = UIViewController()
        let modal = ArtworkIntroductionModal(frame: CGRect(x: 0, y: 200, width: 400, height: 800), artwork: .mockData, descrption: .mockData)
        vc.view.addSubview(modal)
        let safeArea = vc.view.safeAreaLayoutGuide
        modal.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            modal.topAnchor.constraint(equalTo: safeArea.topAnchor),
            modal.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            modal.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            modal.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
        ])
        changeRootViewController(vc)
    }

    // 확대/축소 가능한 이미지 뷰를 테스트할 수 있는 코드입니다.
    func testZoomableAsyncImageView() {
        let vc = UIViewController()
        let zoomable = ZoomableAsyncImageView(url: Artwork.mockData.imageUrl)
        vc.view.addSubview(zoomable)
        zoomable.frame = CGRect(x: 0, y: 100, width: 300, height: 300)
        changeRootViewController(vc)
    }

    // 작품 소개 UI를 테스트할 수 있는 코드입니다.
    func testArtworkIntroductionView() {
        let vc = ArtworkIntroductionViewController(QuestionAnswerViewModel())
        let rootVc = UINavigationController(rootViewController: vc)
        changeRootViewController(rootVc)
    }

    // 질문 답변 UI를 테스트할 수 있는 코드입니다.
    func testQuestionAnswerView() {
        let vc = QuestionAnswerViewController(artwork: Artwork.mockData, userId: User.mockData.id)
        let rootVc = UINavigationController(rootViewController: vc)
        changeRootViewController(rootVc)
    }
}
#endif

