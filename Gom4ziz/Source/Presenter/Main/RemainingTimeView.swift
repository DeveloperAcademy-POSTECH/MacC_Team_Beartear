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
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RemainingTimeView {
    
    func addSubviews() {
        
    }
    
    func setUpConstraints() {
        
    }
    
    func setUpUI() {
        
    }
}

// MARK: - Set UI
private extension RemainingTimeView {
    
}

// MARK: - Constraints
private extension RemainingTimeView {
    
}

#if DEBUG
import SwiftUI
struct RemainingTimeViewPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            RemainingTimeView()
                .toPreview()
                .frame(width: 390, height: 520)
        }
    }
}
#endif
