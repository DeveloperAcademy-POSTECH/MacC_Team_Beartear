//
//  RemainingTimeView.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/12/04.
//

import UIKit

final class NoMoreDataView: BaseAutoLayoutUIView {
    
    private let bakingImageView: UIImageView = UIImageView()
    private let bakingLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    private let subTitleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension NoMoreDataView {
    
    func addSubviews() {
        addSubviews(bakingImageView,
                    bakingLabel,
                    titleLabel,
                    subTitleLabel)
    }
    
    func setUpConstraints() {
        setUpBakingImageViewConstraints()
        setUpBakingLabelConstraints()
        setUpTitleLabelConstraints()
        setUpSubTitleLabelConstraints()
    }
    
    func setUpUI() {
        setUpSelf()
        setUpBakingImageView()
        setUpBakingLabel()
        setUpTitleLabel()
        setUpSubTitleLabel()
    }
}

// MARK: - Set UI
private extension NoMoreDataView {
    
    func setUpSelf() {
        backgroundColor = .white
    }
    
    func setUpBakingImageView() {
        bakingImageView.image = UIImage(named: ImageName.noMoreData)
        bakingImageView.contentMode = .scaleAspectFit
    }
    
    func setUpBakingLabel() {
        bakingLabel.text = "재료가 모두 소진되었습니다"
        bakingLabel.textStyle(.SubHeadline, UIColor.gray4)
    }
    
    func setUpTitleLabel() {
        titleLabel.text = "작품을 모두 감상했습니다"
        titleLabel.textStyle(.Display1, UIColor.gray4)
    }
    
    func setUpSubTitleLabel() {
        subTitleLabel.numberOfLines = 2
        subTitleLabel.attributedText = NSAttributedString(string: "궁금한 점이 있으면 인스타그램 @gom4ziz으로\n 연락해 주세요")
        subTitleLabel.textStyle(.Caption, alignment: .center, UIColor.gray4)
    }
}

// MARK: - Constraints
private extension NoMoreDataView {
    
    func setUpBakingImageViewConstraints() {
        bakingImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bakingImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bakingImageView.widthAnchor.constraint(equalToConstant: 244),
            bakingImageView.heightAnchor.constraint(equalToConstant: 185),
            bakingImageView.topAnchor.constraint(equalTo: topAnchor, constant: 60)
        ])
    }
    
    func setUpBakingLabelConstraints() {
        bakingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bakingLabel.topAnchor.constraint(equalTo: bakingImageView.bottomAnchor, constant: 23),
            bakingLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: bakingLabel.bottomAnchor, constant: -5),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setUpSubTitleLabelConstraints() {
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -15),
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

#if DEBUG
import SwiftUI
struct NoMoreDataViewPreview: PreviewProvider {
    static var previews: some View {
        NoMoreDataView()
            .toPreview()
            .frame(width: 390, height: 500)
    }
}
#endif
