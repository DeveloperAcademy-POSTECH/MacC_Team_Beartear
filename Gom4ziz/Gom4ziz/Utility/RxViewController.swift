//
//  RxViewController.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/30.
//

import UIKit

typealias BaseRxViewController = RxViewController & RxViewControllerProtocol

class RxViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewController = self as? RxViewControllerProtocol {
            viewController.setUpObservers()
        }
    }

}

protocol RxViewControllerProtocol: AnyObject {
    func setUpObservers()
}
