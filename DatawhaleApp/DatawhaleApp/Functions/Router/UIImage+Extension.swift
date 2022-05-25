//
//  UIColor+Extension.swift
//  DatawhaleApp
//
//  Created by Hab Yang on 2022/2/25.
//

import Foundation
import UIKit

extension UIImage {
    /// generate ColorImage
    /// - Parameter color: input Color
    /// - Returns: Image
    class func creatImageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x:0,y:0,width:1,height:1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

