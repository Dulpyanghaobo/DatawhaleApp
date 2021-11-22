//
//  DWHomeBoardCell.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/15.
//

import UIKit

class DWHomeBoardCell: UICollectionViewCell {

    // MARK: - static
    static let reuseIdentifier = String(describing: DWHomeBoardCell.self)
    
    static let size = CGSize(width: DWScreenWidth - 16 * 2, height: 204)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        p_setUpUI()
    }
    
    func p_setUpUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.addSubview(rightButton)
        contentView.addSubview(leftLabel)
        contentView.addSubview(progressView)
        p_addMasonry()
    }
    func p_addMasonry() {
        rightButton.snp.makeConstraints{(make) in
            make.size.equalTo(CGSize.init(width: 82, height: 26))
            make.right.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(24)
        }
        leftLabel.snp.makeConstraints{(make) in
            make.left.top.equalToSuperview().offset(24)
            make.right.lessThanOrEqualTo(rightButton.snp.left).offset(-55)
        }
        progressView.snp.makeConstraints{
            $0.top.equalTo(leftLabel.snp.bottom).offset(12)
            $0.left.equalTo(leftLabel)
            $0.size.equalTo(CGSize(width: 84, height: 84))
        }
    }
    func p_setUpData() {
        self.rightButton.outputDelegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private let leftLabel : UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.text = "做不好时间管理?让我们来提醒你"
        label.numberOfLines = 0
        label.font = UIFont.meduimFont(14)
        return label
    } ()
    
    private let rightButton : DWCustomTitleImageButton = {
        let rightButton = DWCustomTitleImageButton.init(frame: CGRect.init(x: 0, y: 0, width: 86, height: 26))
        let layer = CAGradientLayer.init(colors: [UIColor.colorWithHexStr("0D67B3"),UIColor.colorWithHexStr("238085")], locations: [0.0,1.0], startPoint: CGPoint.init(x: 0.5, y: 0), endPoint: CGPoint.init(x: 0.5, y: 1), type: CAGradientLayerType.axial)
        layer.position = rightButton.center
        let layerBackView = CALayer()
        layerBackView.backgroundColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layerBackView.position = rightButton.center
        layerBackView.bounds = rightButton.bounds
        rightButton.customLayer = layer
        rightButton.layer.insertSublayer(layerBackView, at: 1)
        rightButton.title = "提醒"
        rightButton.image = "home_remind_cion"
        rightButton.imagePadding = 2
        return rightButton
    } ()
    
    private lazy var progressView : UIProgressView = {
        let progressView = UIProgressView.init(progressViewStyle: UIProgressView.Style.bar)
        progressView.progress = 0.4
        return progressView
    } ()
}

extension DWHomeBoardCell : HFSCustomTitleImageButtonOutputProtocol
{
    func clickAction(sender: UIView) {
        
    }
    
    
}
