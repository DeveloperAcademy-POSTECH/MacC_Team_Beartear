//
//  SectionTitleView.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/23.
//

import UIKit

final class SectionTitleView: UIView {
    
    let title: String
    
    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.textStyle(.Headline2, .blackFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sectionTitleDividerView: UIView = {
        let divider = UIView()
        divider.backgroundColor = .blackFont
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    private lazy var sectionTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sectionTitleLabel,
                                                       sectionTitleDividerView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        addSubviews()
        setUpConstraints()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SectionTitleView {
    func addSubviews() {
        self.addSubview(sectionTitleStackView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            sectionTitleStackView.topAnchor.constraint(equalTo: self.topAnchor),
            sectionTitleStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            sectionTitleStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            sectionTitleStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            sectionTitleLabel.topAnchor.constraint(equalTo: sectionTitleStackView.topAnchor),
            
            sectionTitleDividerView.leftAnchor.constraint(equalTo: sectionTitleLabel.leftAnchor),
            sectionTitleDividerView.rightAnchor.constraint(equalTo: sectionTitleLabel.rightAnchor),
            sectionTitleDividerView.bottomAnchor.constraint(equalTo: sectionTitleStackView.bottomAnchor),
            sectionTitleDividerView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    func setUpUI() {
        self.backgroundColor = .white
    }
}
