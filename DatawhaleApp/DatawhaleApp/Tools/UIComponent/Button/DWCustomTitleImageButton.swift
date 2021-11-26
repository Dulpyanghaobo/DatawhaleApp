//
//  DWCustomTitleImageButton.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/15.
//

import UIKit
enum HFSCustomTitleIamgeType : Int {
    case ImageTextMerge //!< 文字图片合并
    case ImageFixed //!< 固定图片位置
    case TextFixed //!< 文字固定
}

enum HFSCustomTitleImageAlignType : Int {
    case BottomAlign
    case TopAlign
    case LeftAlign
    case RightAlign
}

protocol HFSCustomTitleImageButtonOutputProtocol : NSObjectProtocol{
    func clickAction(sender : UIView)
}

class DWCustomTitleImageButton: UIView {

    weak var outputDelegate : HFSCustomTitleImageButtonOutputProtocol?
    
    public var type : HFSCustomTitleIamgeType = .ImageTextMerge {
        didSet {
            switch type {
            case .ImageFixed:
                break
            case .TextFixed:
                break
            case .ImageTextMerge:
                break
            }
        }
    }
    
    public var alignType : HFSCustomTitleImageAlignType = .BottomAlign {
        didSet {
            self.imageView.snp.removeConstraints()
            switch alignType {
            case .BottomAlign:
                break
            case .LeftAlign:
                self.imageView.snp.makeConstraints { make in
                    make.left.equalTo(titleLabel.snp.right).offset(6)
                    make.right.equalToSuperview().offset(-10)
                    make.bottom.equalTo(self.titleLabel.snp.bottom)
                }
                break
            case .TopAlign:
                break
            case .RightAlign:
                break
            }

        }
    }
    // 文字标题
    public var title : String = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
    // 图片与文字距离
    public var imagePadding : CGFloat = 4 {
        didSet {
            switch alignType {
            case .BottomAlign:
                imageView.snp.updateConstraints { make in
                    make.top.equalTo(self.titleLabel.snp.bottom).offset(imagePadding)
                }
                break
            case .LeftAlign:
                imageView.snp.updateConstraints { make in
                    make.left.equalTo(self.titleLabel.snp.right).offset(imagePadding)
                }
                break
            case .TopAlign:
                imageView.snp.updateConstraints { make in
                    make.bottom.equalTo(self.titleLabel.snp.top).offset(imagePadding)
                }
                break
            case .RightAlign:
                imageView.snp.updateConstraints { make in
                    make.left.equalTo(self.titleLabel.snp.right).offset(imagePadding)
                }
                break
            }
        }
    }
    // 文字颜色
    public var textColor = UIColor.white {
        didSet {
            self.titleLabel.textColor = textColor
        }
    }
    
    // 图片url
    public var image : String = "" {
        didSet {
            if let image = UIImage.init(named: image) {
                self.imageView.image = image
            }
        }
    }
    // 背景层
    public var customLayer = CALayer() {
        didSet {
            if let layers = self.layer.sublayers {
                if (!layers.contains(customLayer)) {
                    self.layer.insertSublayer(customLayer, at: 0)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGestureView = UITapGestureRecognizer(target: self, action: #selector(viewTapAction))
        addGestureRecognizer(tapGestureView)
        setUpView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("titleImageButtonView")
    }
    
    func setUpView() {
        addSubview(titleLabel)
        addSubview(imageView)
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(6)
            $0.bottom.equalToSuperview().offset(-6)
            $0.left.equalToSuperview().offset(16)
        }
        imageView.snp.makeConstraints{
            $0.centerY.equalTo(titleLabel)
            $0.left.equalTo(titleLabel.snp.right).offset(6)
            $0.right.equalToSuperview().offset(-14)
        }
        self.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.customLayer.frame = self.bounds
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    @objc func viewTapAction() {
        if let delegate = self.outputDelegate {
            delegate.clickAction(sender: self)
        }
    }
    
    // MARK: - lazy
    private lazy var titleLabel : UILabel = {
        var titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.regularFont(14)
        return titleLabel
    } ()
    
    private lazy var imageView : UIImageView = {
        var imageView = UIImageView()
        return imageView
    } ()
    
    
}
