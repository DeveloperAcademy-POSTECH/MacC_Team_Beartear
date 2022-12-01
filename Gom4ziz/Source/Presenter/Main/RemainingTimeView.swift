//
//  RemainingTimeView.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/30.
//

import UIKit

final class RemainingTimeView: BaseAutoLayoutUIView {
    
    private let bakingImageView: UIImageView = UIImageView()
    private let bakingLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    private let subTitleLabel: UILabel = UILabel()
    var remainingTimeStatus: RemainingTimeStatus? {
        didSet {
            setUpBakingImageView()
            setUpBakingLabel()
            setUpSubTitleLabel()
        }
    }
    
    init(_ timeStatus: RemainingTimeStatus) {
        self.remainingTimeStatus = timeStatus
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension RemainingTimeView {
    
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
private extension RemainingTimeView {
    
    func setUpSelf() {
        backgroundColor = .white
    }
    
    func setUpBakingImageView() {
        guard let remainingTimeStatus else { return }
        bakingImageView.image = UIImage(named: remainingTimeStatus.bakingStatusImageName)
        bakingImageView.contentMode = .scaleAspectFit
    }
    
    func setUpBakingLabel() {
        guard let remainingTimeStatus else { return }
        bakingLabel.text = remainingTimeStatus.bakingStatusString
        bakingLabel.textStyle(.SubHeadline, UIColor.gray4)
    }
    
    func setUpTitleLabel() {
        titleLabel.text = "새로운 작품이 없습니다"
        titleLabel.textStyle(.Display1, UIColor.gray4)
    }
    
    func setUpSubTitleLabel() {
        guard let remainingTimeStatus else { return }
        subTitleLabel.text = "다음 업로드까지 \(remainingTimeStatus.remainingTimeToString) 남았습니다"
        subTitleLabel.textStyle(.Headline1, UIColor.gray4)
    }
}

// MARK: - Constraints
private extension RemainingTimeView {
    
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
            titleLabel.topAnchor.constraint(equalTo: bakingLabel.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setUpSubTitleLabelConstraints() {
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -3),
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48)
        ])
    }
}

#if DEBUG
import SwiftUI
struct RemainingTimeViewPreview1: PreviewProvider {
    static var previews: some View {
        RemainingTimeView(.moreThanOneDay(day: 3))
            .toPreview()
            .frame(width: 390, height: 400)
            .previewDisplayName("1일 이상 남음")
    }
}

struct RemainingTimeViewPreview2: PreviewProvider {
    static var previews: some View {
        RemainingTimeView(.lessThanDayMoreThanHour(hour: 4))
            .toPreview()
            .frame(width: 390, height: 400)
            .previewDisplayName("1시간 이상 남음")
    }
}

struct RemainingTimeViewPreview3: PreviewProvider {
    static var previews: some View {
        RemainingTimeView(.lessThanOneHour(minute: 39))
            .toPreview()
            .frame(width: 390, height: 400)
            .previewDisplayName("1시간 미만 남음")
    }
}
#endif
