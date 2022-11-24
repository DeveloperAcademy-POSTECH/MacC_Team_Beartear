//
//  UIImage.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/23.
//

import UIKit

enum ImageFilterOption {
    case contrast(Double)
    case exposure(Double)
}

extension UIImage {

    func setFilters(filterOptions: [ImageFilterOption]) -> UIImage? {
        guard var inputImage = CIImage(image: self) else {
            return nil
        }

        // 이미지에 필터를 적용합니다.
        for filterOption in filterOptions {
            switch filterOption {
            case .exposure(let value):
                inputImage = inputImage.setExposure(value: value)
            case .contrast(let value):
                inputImage = inputImage.setContrast(value: value)
            }
        }

        let context: CIContext = CIContext(options: nil)
        guard let image = context.createCGImage(inputImage, from: inputImage.extent) else {
            return nil
        }

        // 필터가 적용된 이미지를 반환합니다.
        return UIImage(cgImage: image)
    }
}

private extension CIImage {
    func setContrast(value: Double) -> CIImage {
        applyingFilter("CIColorControls", parameters: [
            kCIInputContrastKey: NSNumber(value: value)
        ])
    }

    func setExposure(value: Double) -> CIImage {
        applyingFilter("CIExposureAdjust", parameters: [
            kCIInputEVKey: NSNumber(value: value)
        ])
    }
}
