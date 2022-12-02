//
//  TempSkeletonImageViewController.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/12/02.
//

import UIKit

final class TempSkeletonImageViewController: UIViewController {
    
    private let imageView: UIImageView = UIImageView()
    
    let imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        addSubviews()
        setUpConstraints()
        setUpUI()
    }
}

extension TempSkeletonImageViewController {
    
    func addSubviews() {
        view.addSubview(imageView)
    }
    
    func setUpConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        setUpImageViewUI()
    }
    
    func setUpImageViewUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: imageName)
    }
    
}

#if DEBUG
import SwiftUI
struct TempSkeletonImageViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: TempSkeletonImageViewController(imageName: ImageName.mainLoading))
            .toPreview()
    }
}
#endif
