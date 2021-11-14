//
//  DWTabBarController.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/14.
//

import UIKit

class DWTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeViewController = DWHomeViewController.init()
        let meViewController = DWMeViewController.init()
        let homeNavigationController = DWNavigationController.init(rootViewController: homeViewController)
        homeNavigationController.tabBarItem = tabBarItem(title: "home", imageName: "", selectedImageName: "")
//        navigationController.tabBarItem;
        let meNavigationController = DWNavigationController.init(rootViewController: meViewController)
        meNavigationController.tabBarItem = tabBarItem(title: "me", imageName: "", selectedImageName: "")
//        let tabbar =

//        navigationController.tabBarItem;
//        let navigationController = DWNavigationController.init(rootViewController: <#T##UIViewController#>)
//        navigationController.tabBarItem;
        // Do any additional setup after loading the view.
        let tabbar = DWTabBar.init()
        tabbar.unselectedItemTintColor = UIColor.black

        self.setValue(tabbar, forKey: "tabBar")
        self.delegate = self
        self.viewControllers = [homeNavigationController, meNavigationController]
    }
    
    // MARK: - Private Method
    func tabBarItem(title : String, imageName : String, selectedImageName : String) -> UITabBarItem {
        let image = UIImage.init(named: imageName)
        let selectImage = UIImage.init(named: selectedImageName)
        let tabBarItem = UITabBarItem.init(title: title, image: image, selectedImage: selectImage)
        return tabBarItem
    }

}

extension DWTabBarController : UITabBarControllerDelegate
{
    /// 选中当前tabbar出发当前方法
    /// - Parameters:
    ///   - tabBarController: tabbarController
    ///   - viewController: 当前ViewController
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
