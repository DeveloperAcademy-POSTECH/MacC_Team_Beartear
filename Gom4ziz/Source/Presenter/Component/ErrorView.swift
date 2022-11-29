//
//  ErrorView.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/27.
//

import UIKit

final class ErrorView: BaseAutoLayoutUIView {
    
    private enum Size {
        static let messageStackViewSpcing: CGFloat = 4
        static let errorStackViewSpcing: CGFloat = 20
        static let buttonWidth: CGFloat = 154
        static let buttonHeight: CGFloat = 48
    }
    
    private let message: ErrorViewMessage
    private let isShowLogo: Bool
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        // TODO: 이미지 불러오는 로직 추가
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = message.rawValue
        label.textStyle(.Title, .blackFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "아래 버튼을 탭해서 다시 불러와 보세요."
        label.textStyle(.NavigationButton, .systemGray) // TODO: systemGray -> gray3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var messageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [errorMessageLabel,
                                                       captionLabel])
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = Size.messageStackViewSpcing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var retryButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("탭하여 다시 시도 ↻", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.backgroundColor = .gray4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var errorStackView: UIStackView = {
        let stackView = UIStackView()
        if isShowLogo {
            stackView.addArrangedSubview(logoImageView)
        }
        stackView.addArrangedSubview(messageStackView)
        stackView.addArrangedSubview(retryButton)
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = Size.errorStackViewSpcing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(message: ErrorViewMessage, isShowLogo: Bool = true) {
        self.message = message
        self.isShowLogo = isShowLogo
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ErrorView {
    
    func addSubviews() {
        self.addSubview(errorStackView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            errorStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            retryButton.widthAnchor.constraint(equalToConstant: Size.buttonWidth),
            retryButton.heightAnchor.constraint(equalToConstant: Size.buttonHeight)
        ])
    }
    
    func setUpUI() {
        self.backgroundColor = .white
    }
    
}

#if DEBUG
import SwiftUI
struct ErrorViewPreview: PreviewProvider {
    static var previews: some View {
        ErrorView(message: .tiramisul, isShowLogo: false).toPreview()
    }
}
#endif
