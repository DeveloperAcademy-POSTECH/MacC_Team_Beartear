//
//  UIImage.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/23.
//

import UIKit

extension UIImage {
    func setFilter(contrast: Double? = nil, exposure: Double? = nil) -> UIImage? {
        guard contrast != nil || exposure != nil else {
            return self
        }
        guard var inputImage = CIImage(image: self) else {
            return nil
        }
        if let contrast {
            inputImage = inputImage.applyingFilter("CIColorControls", parameters: [
                kCIInputContrastKey: NSNumber(value: contrast)
            ])
        }
        if let exposure {
            inputImage = inputImage.applyingFilter("CIExposureAdjust", parameters: [
                kCIInputEVKey: NSNumber(value: exposure)
            ])
        }
        let context: CIContext = CIContext(options: nil)
        guard let image = context.createCGImage(inputImage, from: inputImage.extent) else {
            return nil
        }
        return UIImage(cgImage: image)
    }
}
