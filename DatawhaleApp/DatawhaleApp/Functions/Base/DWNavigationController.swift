//
//  DWNavigationController.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/14.
//

import UIKit

class DWNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 隐藏navgatorbar细线
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearence = UINavigationBarAppearance.init()
        navigationBarAppearence.shadowColor = .clear
        navigationBar?.scrollEdgeAppearance = navigationBarAppearence
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
            self.navigationBar.isHidden = false
        }
        super.pushViewController(viewController, animated: animated)
    }

}
