//
//  CustomSectionHeaderView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/12/06.
//

import UIKit

final class CustomSectionHeaderView: UITableViewHeaderFooterView {
    private let sectionTitleView = SectionTitleView(title: "감상 기록")

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(sectionTitleView)
        sectionTitleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionTitleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            sectionTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            sectionTitleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            sectionTitleView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

#if DEBUG
import SwiftUI
struct CustomSectionHeaderViewPreview: PreviewProvider {
    static var previews: some View {
        CustomSectionHeaderView().toPreview()
    }
}
#endif
