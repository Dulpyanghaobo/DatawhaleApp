//
//  DWBaseViewController.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/14.
//

import UIKit

class DWBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad: \(self)")
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)]
        modalPresentationStyle = .fullScreen
        view.backgroundColor = UIColor.lightGray6()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 默认开启导航栏展示
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("[\(self) viewDidAppear]")
    }
    
    /// 返回按钮点击事件
    /// - Parameter sender: 当前点击视图
    func back(sender : Any) {
        if navigationController?.viewControllers.count == 1 {
            self.dismiss(animated: true) {
                
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    // 当前状态栏默认偏好
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // 视图消失后会走当前方法
    deinit {
        debugPrint("\(self)")
    }
    
    
}
