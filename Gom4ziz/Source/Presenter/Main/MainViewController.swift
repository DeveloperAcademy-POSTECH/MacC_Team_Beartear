//
//  MainViewController.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import UIKit

import RxCocoa
import RxSwift

final class MainViewController: UIViewController {
    
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        
    }
    
    override func loadView() {
    }
}

private extension MainViewController {
    
    func setUpObservers() {
        
    }
}

#if DEBUG
import SwiftUI
struct MainViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: MainViewController())
            .toPreview()
    }
}
#endif
