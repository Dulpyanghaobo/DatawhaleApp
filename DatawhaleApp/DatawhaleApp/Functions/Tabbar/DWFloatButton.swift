//
//  DWFloatButton.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/15.
//

import UIKit
import SnapKit

enum DWFloatButtonActionType {
case openTask,openExercise,openStudy,openAILab
}

protocol DWFloatButtonActionDelegate : NSObjectProtocol {
    func open()
    func close()
    func clickItem(openActionType : DWFloatButtonActionType)
}


@objc class DWFloatButton : UIView {
    // 调用三方浮动按钮
    fileprivate let actionButton = JJFloatingActionButton()
    
    weak var delegate : DWFloatButtonActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let visiEffect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: visiEffect)
        effectView.frame = CGRect(x: 0, y: 0, width: DWScreenWidth, height: DWScreenHeight)
        addSubview(effectView)
        addSubview(actionButton)
        actionButton.circleView.color = .clear
        actionButton.buttonImage = UIImage.init(named: "tabbar_close_image")
        actionButton.buttonImageSize = CGSize(width: 48, height: 48)
        actionButton.delegate = self
        setUpView()
        let configuration = JJItemAnimationConfiguration()
        configuration.itemLayout = JJItemLayout(layout: { items, actionButton in
            for (i, item) in items.enumerated() {
                switch i {
                case 0:
                    item.snp.makeConstraints{(make) in
                        make.centerX.equalTo(actionButton.snp.centerX).offset(-56)
                        make.bottom.equalTo(actionButton.snp.top).offset(-80)
                    }
                    break
                case 1:
                    item.snp.makeConstraints{(make) in
                        make.right.equalTo(actionButton.snp.left).offset(-72)
                        make.bottom.equalTo(actionButton.snp.top).offset(0)
                    }
                    break
                case 2:
                    item.snp.makeConstraints{(make) in
                        make.left.equalTo(actionButton.snp.right).offset(72)
                        make.bottom.equalTo(actionButton.snp.top).offset(0)
                    }
                    break
                case 3:
                    item.snp.makeConstraints{(make) in
                        make.centerX.equalTo(actionButton.snp.centerX).offset(56)
                        make.bottom.equalTo(actionButton.snp.top).offset(-80)
                    }
                    break
                default:
                    item.snp.makeConstraints{(make) in
                        make.right.equalTo(actionButton.snp.left).offset(-55)
                        make.bottom.equalTo(actionButton.snp.top).offset(0)
                    }
                    break
                }

            }
        })

        actionButton.itemAnimationConfiguration = configuration
        actionButton.buttonAnimationConfiguration = .rotation(toAngle: .pi)
        actionButton.buttonAnimationConfiguration.opening.duration = 0.8
        actionButton.buttonAnimationConfiguration.closing.duration = 0.6
        // 对应的item配置
        actionButton.addItem(title: "AILab", image: #imageLiteral(resourceName: "icon_items_bottom_ai")) { item in
            self.delegate?.clickItem(openActionType: DWFloatButtonActionType.openAILab)
        }

        actionButton.addItem(title: "Record", image: #imageLiteral(resourceName: "icon_items_bottom_study")) { item in
            self.delegate?.clickItem(openActionType: DWFloatButtonActionType.openStudy)
        }

        actionButton.addItem(title: "Exercise", image: #imageLiteral(resourceName: "icon_items_bottom_exercise")) { item in
            self.delegate?.clickItem(openActionType: DWFloatButtonActionType.openExercise)
        }
        actionButton.addItem(title: "Task", image: #imageLiteral(resourceName: "icon_items_bottom_task")) { item in
            self.delegate?.clickItem(openActionType: DWFloatButtonActionType.openTask)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        actionButton.snp.makeConstraints{(make) in
            make.bottom.equalToSuperview().offset(-10 - DWSafBottomSpace)
            make.centerX.equalToSuperview()
        }
    }
}

extension DWFloatButton : JJFloatingActionButtonDelegate
{
    func floatingActionButtonWillOpen(_ button: JJFloatingActionButton) {
        self.delegate?.open()
    }
    
    func floatingActionButtonDidOpen(_ button: JJFloatingActionButton) {
        
    }
    
    func floatingActionButtonDidClose(_ button: JJFloatingActionButton) {
    }
    
    func floatingActionButtonWillClose(_ button: JJFloatingActionButton) {
        self.delegate?.close()
    }
}

extension DWFloatButton
{
    @objc func open() {
        self.actionButton.buttonState = .closed
        self.actionButton.buttonWasTapped()
    }
}

