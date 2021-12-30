//
//  DWMeViewController.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/14.
//

import UIKit

class DWMeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headView)
        headView.snp.makeConstraints{
            $0.top.right.left.equalToSuperview().offset(0)
            $0.height.equalTo(324)
        }
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints{
            $0.top.equalTo(headView.snp.bottom).offset(64)
            $0.left.equalToSuperview().offset(32)
            $0.right.equalToSuperview().offset(-32)
            $0.height.equalTo(44)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    // MARK: -
    @objc func didTapLogin() {
        let loginViewController = DWLoginViewController.init()
        /// self.navigationController当前视图的导航栏推入一个登录界面的视图控制器，animated=true表示开启动画
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    private lazy var headView : UIView = {
        var headView = UIView.init(frame: .zero)
        headView.backgroundColor = .red
        return headView
    } ()
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("进入登录界面", for: .normal)
        button.backgroundColor = UIColor.brandBlueColor()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.meduimFont(16)
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    } ()
    
}
