//
//  DWTabBar.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/14.
//

import UIKit
import CoreData

class DWTabBar: UITabBar ,DWFloatButtonActionDelegate{

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.floatButton.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 设置UI
    func setupView() {
        let backView = UIView.init(frame: CGRect.init(x: 0, y: -16, width: DWScreenWidth, height: 79))
        insertSubview(backView, at: 0)
        let imageView = UIImageView.init(image: UIImage.init(named: "tabbar_bg"))
        imageView.contentMode = .scaleAspectFill
        imageView.frame = backView.frame
        backView.addSubview(imageView)
        backgroundColor = UIColor.white
        addSubview(centerButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let centerAddWidth = 56
        var itemWidth : Int = 0
        if let count = self.items?.count {
            itemWidth = (DWScreenWidth - centerAddWidth) / count
        }

        let centerAddIndex = 1
        self.centerButton.frame = CGRect.init(x: itemWidth, y: -17, width: centerAddWidth, height: centerAddWidth)
        self.items?.map({
            $0.imageInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: -10, right: 0)
            $0.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.regularFont(11),NSAttributedString.Key.foregroundColor : UIColor.lightGray4()], for: .normal)
            $0.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.regularFont(11),NSAttributedString.Key.foregroundColor : UIColor.brandBlueColor()], for: .selected)
        })
        var tabBarButtonIndex = 0
        self.subviews.map { child in
            if child.isKind(of: NSClassFromString("UITabBarButton")!) {
                var spaceX : Int = 0
                if tabBarButtonIndex == centerAddIndex {
                    spaceX = centerAddWidth
                }
                let frame = CGRect.init(x: tabBarButtonIndex * itemWidth + Int(spaceX), y: -5, width: itemWidth, height: 49)
                child.frame = frame
                tabBarButtonIndex += 1
                
            } else if (child.isKind(of: NSClassFromString("_UIBarBackground")!)) {
                child.isHidden = true
            }
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isHidden {
            return super.hitTest(point, with: event)
        }
        
        let touch = self.convert(point, to: self.centerButton)
        if self.centerButton.point(inside: touch, with: event) {
            return self.centerButton
        }
        return super.hitTest(point, with: event)
    }
    
    @objc func didTapAction() {
        DWNavigator.keyWindow().addSubview(self.floatButton)
        self.floatButton.open()
    }
    
    private let centerButton : UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "tabbar_center_button"), for: .normal)
        button.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        return button
    } ()
    
    private let floatButton : DWFloatButton = {
        let floatButton = DWFloatButton.init(frame: CGRect.init(x: 0, y: 0, width: DWScreenWidth, height: DWScreenHeight))
        return floatButton
    } ()
}

extension DWTabBar
{
    func open() {
        
    }
    
    func close() {
        self.floatButton.removeFromSuperview()
    }
    
    func clickItem(openActionType: DWFloatButtonActionType) {
        
    }
    
    
}
