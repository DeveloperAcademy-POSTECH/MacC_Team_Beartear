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
    private let userViewModel = UserViewModel.shared
    private let onBoardingViewModel: OnBoardingViewModel = OnBoardingViewModel()
    private lazy var pageViewController = OnBoardingPageViewController(
        viewControllerList: pageViewControllerList,
        onBoardingViewModel: onBoardingViewModel
    )
    private let onBoardingButton = OnBoardingButton(text: "다음으로")
    private let skipButton: UIButton = UIButton()
    private let pageControlContainer: PageIndexIndicatorView = PageIndexIndicatorView(totalCount: 3)
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addSubviews()
        setUpConstraints()
        setObservers()
    }
}

private extension OnBoardingViewController {
    
    func setObservers() {
        onBoardingViewModel
            .currentPageIdx
            .do(onNext: { [weak self] in
                guard let self else { return }
                let buttonText = $0 == self.pageViewControllerList.count - 1 ? "시작하기" : "다음으로"
                self.onBoardingButton.setUpUI(text: buttonText)
            })
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.changeSkipButtonUI(with: $0)
                self.changePageControlState(with: $0)
            })
            .disposed(by: disposeBag)
        
        onBoardingButton
            .rx
            .tap
            .bind {
                self.goNextPageOrSignIn()
            }
            .disposed(by: disposeBag)
        
        skipButton
            .rx
            .tap
            .bind {
                self.skipOnBoarding()
            }
            .disposed(by: disposeBag)
    }
    
    func goNextPageOrSignIn() {
        let currentIdx = onBoardingViewModel.currentPageIdx.value
        guard let currentViewController = pageViewController.viewControllers?[0] else { return }
        if let nextPage = pageViewController.dataSource?.pageViewController(pageViewController, viewControllerAfter: currentViewController) {
            pageViewController.setViewControllers([nextPage], direction: .forward, animated: true)
            onBoardingViewModel
                .currentPageIdx
                .accept(currentIdx + 1)
        } else {
            skipOnBoarding()
        }
    }
    
    func skipOnBoarding() {
        // TODO: 유저 서버에 등록 registerUser
        userViewModel
            .fetchUser()
    }
}

private extension OnBoardingViewController {
    
    func addSubviews() {
        addPageViewController()
        view.addSubviews(onBoardingButton,
                        skipButton,
                        pageControlContainer)
    }
    
    func setUpConstraints() {
        setUpSkipButtonConstraints()
        setUpPageViewControllerConstraints()
        setUpPageControlContainerConstraints()
        setUpOnBoardingButtonConstraints()
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        setUpPageControlContainer()
        setUpSkipButton(text: "Skip")
    }
}

private extension OnBoardingViewController {
    
    func changeSkipButtonUI(with currentIndex: Int) {
        if currentIndex == pageViewControllerList.count - 1 {
            skipButton.isHidden = true
            skipButton.isEnabled = false
        } else {
            skipButton.isHidden = false
            skipButton.isEnabled = true
        }
    }
    
    func changePageControlState(with currentIndex: Int) {
        pageControlContainer.currentSelectedIndex = currentIndex
    }
    
    func setUpPageControlContainer() {
        pageControlContainer.backgroundColor = .white
    }
    
    func setUpSkipButton(text: String) {
        var configuration = UIButton.Configuration.plain()
        let attributes = skipButton.textStyleAttributes(.Title, .gray3)
        configuration.attributedTitle = AttributedString(text, attributes: attributes)
        skipButton.configuration = configuration
    }
}

// MARK: - Constraints

private extension OnBoardingViewController {
    
    func addPageViewController() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    func setUpSkipButtonConstraints() {
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setUpPageViewControllerConstraints() {
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 30),
            pageViewController.view.bottomAnchor.constraint(equalTo: pageControlContainer.topAnchor, constant: -16)
        ])
        
    }
    
    func setUpPageControlContainerConstraints() {
        pageControlContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControlContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControlContainer.bottomAnchor.constraint(equalTo: onBoardingButton.topAnchor, constant: -40)
        ])
    }
    
    func setUpOnBoardingButtonConstraints() {
        onBoardingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
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
