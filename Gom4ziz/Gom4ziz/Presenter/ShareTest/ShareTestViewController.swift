//
//  ShareTestViewController.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/23.
//

import UIKit

import RxSwift

final class ShareTestViewController: UIViewController {

    private lazy var shareTestView: ShareTestView = ShareTestView()
    private let disposeBag: DisposeBag = .init()
    private let kakaoMessageSender: KakaoMessageSender = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpObserver()
    }

    override func loadView() {
        self.view = shareTestView
    }
}

private extension ShareTestViewController {
    func setUpObserver() {
        shareTestView.shareButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.kakaoMessageSender.sendMessage(.invite(room: PlansRoom.mockData))
            })
            .disposed(by: disposeBag)
    }
}

#if DEBUG
import SwiftUI
struct ShareTestPreview: PreviewProvider {
    static var previews: some View {
        ShareTestViewController().toPreview()
    }
}
#endif
