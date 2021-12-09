//
//  DWNavigator.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/15.
//

import Foundation

struct DWNavigator
{
    
    static func push(viewController : UIViewController) {
        
    }
    
    static func currentController() -> UIViewController {
        let viewController = findBestViewController(viewController: self.keyWindow().rootViewController!)
        return viewController
    }
    
    static func findBestViewController(viewController : UIViewController) -> UIViewController {
        if ((viewController.presentedViewController) != nil) {
            return self.findBestViewController(viewController: viewController.presentedViewController!)
        } else if viewController is UISplitViewController {
            let viewController = viewController as! UISplitViewController
            return viewController.viewControllers.count > 0 ? self.findBestViewController(viewController: viewController.viewControllers.last!) : viewController
        } else if viewController is UINavigationController {
            let navigationController = viewController as! UINavigationController
            return navigationController.viewControllers.count > 0 ? self.findBestViewController(viewController: navigationController.topViewController ?? viewController) : viewController
        } else if viewController is UITabBarController {
            let tabbarViewControler = viewController as! UITabBarController
            return tabbarViewControler.viewControllers?.count ?? 0 > 0 ? self.findBestViewController(viewController: tabbarViewControler.selectedViewController ?? viewController) : viewController
        }
        return viewController
    }
    
    static func keyWindow() -> UIWindow {

        for window in UIApplication.shared.windows {
            if window.windowLevel == .normal {
                return window
            }
        }
        return UIWindow.init(frame: CGRect.init(x: 0, y: 0, width: DWScreenWidth, height: DWScreenHeight))
    }
}
