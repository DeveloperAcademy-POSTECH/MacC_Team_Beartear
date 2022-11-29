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
    private let onBoardingViewModel: OnBoardingViewModel = OnBoardingViewModel()
    private lazy var pageViewController = OnBoardingPageViewController(
        viewControllerList: pageViewControllerList,
        onBoardingViewModel: onBoardingViewModel
    )
    private let onBoardingButton = OnBoardingButton(text: "다음으로")
    private let skipButton: UIButton = SkipButton(text: "Skip")
    private let skipButtonContainer: UIView = UIView()
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
                self.goNextPage()
            }
            .disposed(by: disposeBag)
        
        skipButton
            .rx
            .tap
            .bind {
                print("skip")
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
        view.addSubviews(onBoardingButton,
                         skipButtonContainer,
                        skipButton,
                        pageControlContainer)
    }
    
    func setUpConstraints() {
        setUpSkipButtonContainerConstraints()
        setUpSkipButtonConstraints()
        setUpPageViewControllerConstraints()
        setUpPageControlContainerConstraints()
        setUpOnBoardingButtonConstraints()
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        setUpSkipButtonContainer()
        setUpPageControlContainer()
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
    
    func setUpSkipButtonContainer() {
        skipButtonContainer.backgroundColor = .white
    }
    
    func setUpPageControlContainer() {
        pageControlContainer.backgroundColor = .white
    }
}

// MARK: - Constraints

private extension OnBoardingViewController {
    
    func addPageViewController() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    func setUpSkipButtonContainerConstraints() {
        skipButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skipButtonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skipButtonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skipButtonContainer.topAnchor.constraint(equalTo: view.topAnchor),
            skipButtonContainer.heightAnchor.constraint(equalToConstant: 124)
        ])
    }
    
    func setUpSkipButtonConstraints() {
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: skipButtonContainer.topAnchor, constant: 70),
            skipButton.trailingAnchor.constraint(equalTo: skipButtonContainer.trailingAnchor, constant: -16)
        ])
    }
    
    func setUpPageViewControllerConstraints() {
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: skipButtonContainer.bottomAnchor),
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
            onBoardingButton.heightAnchor.constraint(equalToConstant: 60),
            onBoardingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onBoardingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onBoardingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
