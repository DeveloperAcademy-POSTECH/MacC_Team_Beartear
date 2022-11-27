//
//  OnBoardingViewController.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import UIKit

import RxSwift

final class OnBoardingViewController: UIViewController {
    
    private let pageViewControllerList = [
        OnBoardingFirstViewController(),
        OnBoardingSecondViewController(),
        OnBoardingThirdViewController()
    ]
    private let onBoardingViewModel: OnBoardingViewModel = OnBoardingViewModel.shared
    private lazy var pageViewController = OnBoardingPageViewController(viewControllerList: pageViewControllerList)
    private let onBoardingButton = OnBoardingButton(text: "다음으로")
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpConstraints()
        setObservers()
    }
}

private extension OnBoardingViewController {
    
    func setObservers() {
        onBoardingViewModel
            .currentPageIdx
            .map {
                return $0 == self.pageViewControllerList.count - 1 ? "시작하기" : "다음으로"
            }
            .subscribe(onNext: { [weak self] in
                self?.onBoardingButton.setUpUI(text: $0)
            })
            .disposed(by: disposeBag)
        
        onBoardingButton
            .rx
            .tap
            .bind {
                self.goNextPage()
            }
            .disposed(by: disposeBag)
    }
    
    func goNextPage() {
        let currentIdx = onBoardingViewModel.currentPageIdx.value
        guard let currentViewController = pageViewController.viewControllers?[0] else { return }
        guard let nextPage = pageViewController.dataSource?.pageViewController(pageViewController, viewControllerAfter: currentViewController) else { return }
        pageViewController.setViewControllers([nextPage], direction: .forward, animated: true)
        onBoardingViewModel
            .currentPageIdx
            .accept(currentIdx + 1)
    }
}

private extension OnBoardingViewController {
    
    func addSubviews() {
        addPageViewController()
        view.addSubview(onBoardingButton)
    }
    
    func setUpConstraints() {
        setUpPageViewControllerConstraints()
        setUpOnBoardingButtonConstraints()
    }
}

// MARK: - Constraints

private extension OnBoardingViewController {
    
    func addPageViewController() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    func setUpPageViewControllerConstraints() {
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func setUpOnBoardingButtonConstraints() {
        onBoardingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onBoardingButton.heightAnchor.constraint(equalToConstant: 60),
            onBoardingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onBoardingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onBoardingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

#if DEBUG
import SwiftUI
struct OnBoardingViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: OnBoardingViewController())
            .toPreview()
    }
}
#endif

