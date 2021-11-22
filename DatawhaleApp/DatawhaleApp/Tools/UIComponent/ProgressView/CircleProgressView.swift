//
//  CircleProgressView.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/22.
//

import UIKit

class CircleProgressView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init error")
    }
    
    func setUpView() {
        backgroundColor = UIColor.clear
        pathBackColor = UIColor.white.withAlphaComponent(0.2)
        pathFillColor = UIColor.white
        strokeWidth = 4
        startAngle = HFSCircleDegree(0)
        reduceAngle = HFSCircleDegree(0)
        duration = 0.5
        realWidth = frame.size.width
        radius = realWidth / 2.0 - strokeWidth / 2.0

        layer.addSublayer(backLayer)
        layer.addSublayer(progressLayer)
        addSubview(pointImageView)
    }
    
    /// 线条背景色
    public var pathBackColor : UIColor = UIColor.lightGray6() {
        didSet {
            
        }
    }
    /// 线条填充色
    public var pathFillColor: UIColor = UIColor.brandBlueColor() {
        didSet {
            
        }
    }
    /// 小圆点图片
    public var pointImage: UIImage?
    /// 起点角度。角度从水平右侧开始为0，顺时针为增加角度。直接传度数,如 -90
    public var startAngle: CGFloat = 0.0 {
        didSet {
            
        }
    }
    /// 减少的角度 直接传度数,如 30
    public var reduceAngle: CGFloat = 0.0 {
        didSet {
            
        }
    }
    /// 线宽
    public var strokeWidth: CGFloat = 0.0 {
        didSet {
        
        }
    }
    /// 动画时长
    public var duration: CGFloat = 0.0 {
        didSet {
            
        }
    }
    /// 是否从上次数值开始动画，默认为NO
    public var increaseFromLast = false {
        didSet {
            
        }
    }
    /// 进度 0-1
    public var progress: CGFloat = 0.0 {
        didSet {
            
        }
    }
    
    var backLayer: CAShapeLayer? {
        didSet {
            
        }
    }
    var progressLayer: CAShapeLayer? {
        didSet {
            
        }
    }
    var pointImageView: UIImageView? {
        didSet {
            
        }
    }
    /// 宽度
    var realWidth: CGFloat = 0.0
    /// 半径
    var radius: CGFloat = 0.0
    /// 上次进度 0-1
    var lastProgress: CGFloat = 0.0
    var lastPointAnimation: CAAnimation?
    
}
