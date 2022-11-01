//
//  AutoLayoutUIView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/30.
//

import UIKit

typealias BaseAutoLayoutUIView = AutoLayoutUIView & AutoLayoutProtocol

class AutoLayoutUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        if let view = self as? AutoLayoutProtocol {
            view.addSubviews()
            view.setUpConstraints()
            view.setUpUI()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        if let view = self as? AutoLayoutProtocol {
            view.addSubviews()
            view.setUpConstraints()
            view.setUpUI()
        }
    }

}

protocol AutoLayoutProtocol: AnyObject {

    /// subView (UI Compoenent 들을 추가하는 함수 (여기서만 추가하세요! 스타일 통일)
    func addSubviews()

    /// subView 들의 AutoLayout Constraint 를 추가하는 함수 (여기서만 제약조건을 거세요! 스타일 통일)
    func setUpConstraints()

    /// 자식뷰의 속성을 추가적으로 설정하거나, UIView 자체의 속성을 추가적으로 설정하는 함수 (여기서만 속성을 변경하세요! 스타일 통일)
    func setUpUI()
}
