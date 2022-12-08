//
//  ZoomableImageViewController.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/12/02.
//

import UIKit

final class ZoomableImageViewController: UIViewController {
    
    enum Size: CGFloat {
        case closeButtonSize = 40
    }
    
    private let zoomableAsyncImageView: ZoomableAsyncImageView
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onCloseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(url: String) {
        self.zoomableAsyncImageView = ZoomableAsyncImageView(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setConstraints()
    }
    
}

private extension ZoomableImageViewController {
    
    func setUpUI() {
        self.view.backgroundColor = .gray1
        self.view.addSubview(zoomableAsyncImageView)
        self.view.addSubview(closeButton)
    }
    
    func setConstraints() {
        zoomableAsyncImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            zoomableAsyncImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            zoomableAsyncImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            zoomableAsyncImageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            zoomableAsyncImageView.widthAnchor.constraint(equalToConstant: self.view.bounds.width),
            
            closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            closeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: Size.closeButtonSize.rawValue),
            closeButton.heightAnchor.constraint(equalToConstant: Size.closeButtonSize.rawValue)
        ])
    }
    
    @objc func onCloseButtonTapped() {
        dismiss(animated: true)
    }
    
}
