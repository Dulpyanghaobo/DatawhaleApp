//
//  ImageCombine.swift
//  DatawhaleApp
//
//  Created by Hab Yang on 2022/2/24.
//

import Foundation
import Vision

struct ImageCombine
{
    func generateCombineImage(foregroundImageData: UIImage?, backgroundImage: UIImage?) -> UIImage? {
        if let ouput = DWImageProcess.shared.processImageFrame(foreground: foregroundImageData?.cgImage, background: backgroundImage?.cgImage, filterType: .person) {
            return UIImage.init(ciImage: ouput)
        }
            return nil
    }
}
