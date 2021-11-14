//
//  UIColor+Extension.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/14.
//

import UIKit

extension UIColor {
    
    //    MARK: - 16进制
    class open func colorWithHexStr(_ hex: String) -> UIColor {
        
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasSuffix("#")) {
            let index = cString.index(cString.startIndex, offsetBy: 1)
            //cString = cString.substring(from: index)
            cString = String(cString[index...]) // Swift 4
        }
        
        if (cString.count != 6) {
            
            return UIColor.red
        }
    
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        //let rString = cString.substring(to: rIndex)
        let rString = String(cString[..<rIndex])
        
        //let otherString = cString.substring(from: rIndex)
        let otherString = String(cString[rIndex...])
        
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        
        //let gString = otherString.substring(to: gIndex)
        let gString =  String(otherString[..<gIndex])
        
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        //let bString = cString.substring(from: bIndex)
        let bString = String(cString[bIndex...])
        
        var r:UInt64 = 0, g:UInt64 = 0, b:UInt64 = 0;
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: (1))
    }
    /// 16进制转化Color
    ///
    /// - Parameters:
    ///   - hex: 16进制
    ///   - alpha: 透明度
    /// - Returns: Color
    open class func colorWithHexStr(_ hex: String, alpha: CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:UInt64 = 0, g:UInt64 = 0, b:UInt64 = 0;
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    // MARK:- RGB的颜色设置
    class func RGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    class func RGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a/1.0)
    }
    
    // MARK: - 随机颜色
    /// 随机颜色
    ///
    /// - Returns: 随机颜色
    class func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(256))
        let green = CGFloat(arc4random_uniform(256))
        let blue = CGFloat(arc4random_uniform(256))
        return RGB(r: red, g: green, b: blue)
    }
}
