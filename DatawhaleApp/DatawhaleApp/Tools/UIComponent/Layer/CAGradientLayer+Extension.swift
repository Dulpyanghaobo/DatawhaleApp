//
//  CAGradientLayer+Extension.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/15.
//

import QuartzCore

@objc public extension CAGradientLayer {
    
    /// 初始化渐变色
    /// - Parameters:
    ///   - colors: 颜色数组
    ///   - locations: 位置
    ///   - startPoint: 开始位置
    ///   - endPoint: 结束为止
    ///   - type: 渐变色类型
    @objc convenience init(colors: [UIColor],
                     locations: [CGFloat]? = nil,
                     startPoint: CGPoint = CGPoint(x: 0.5, y: 0),
                     endPoint: CGPoint = CGPoint(x: 0.5, y: 1),
                     type: CAGradientLayerType = .axial) {
        self.init()
        self.colors = colors.map(\.cgColor)
        self.locations = locations?.map { NSNumber(value: Double($0)) }
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.type = type
    }
}
