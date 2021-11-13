//
//  ViewController.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 将label加入父视图
        view.addSubview(label)
        // 设置label的frame
        label.frame = CGRect.init(x: UIScreen.main.bounds.size.width / 2 - 200 / 2, y: UIScreen.main.bounds.size.height / 2 - 20 / 2, width: 200, height: 20)
    }

    // 文本UI
    private let label : UILabel = {
        let label = UILabel.init(frame: .zero)
        // 展示的文本信息
        label.text = "Hello World"
        // 居中展示
        label.textAlignment = .center
        return label
    } ()

}

