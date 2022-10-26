//
//  AppleTestViewController.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/10/26.
//

import Foundation
import UIKit

final class AppleTestViewController: UIViewController {

    private lazy var appleLoginManager = AppleLoginManager(vc: self)
    private let appleTestView = AppleTestView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        self.view = appleTestView
    }

}
