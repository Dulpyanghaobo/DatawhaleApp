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
        let taskViewController = TaskViewController.init()
        let goalViewController = GoalViewController.init()
        let homeNavigationController = UINavigationController.init(rootViewController: homeViewController)
        homeNavigationController.tabBarItem = tabBarItem(title: "home", imageName: "tabbar_home_icon", selectedImageName: "tabbar_home_select_icon1")
        let taskNavigationController = UINavigationController.init(rootViewController: taskViewController)
        taskNavigationController.tabBarItem = tabBarItem(title: "task", imageName: "task_items_bottom_tabbar", selectedImageName: "task_items_bottom_tabbar")
        let goalNavController = UINavigationController.init(rootViewController: goalViewController)
        goalNavController.tabBarItem = tabBarItem(title: "goal", imageName: "goal_items_bottom_Tabbar", selectedImageName: "goal_items_bottom_Tabbar")
        let meNavigationController = UINavigationController.init(rootViewController: meViewController)
        meNavigationController.tabBarItem = tabBarItem(title: "me", imageName: "tabbar_me_icon", selectedImageName: "tabbar_me_select_icon1")
        let tabbar = DWTabBar.init()
        tabbar.unselectedItemTintColor = UIColor.lightGray4()
        self.setValue(tabbar, forKey: "tabBar")
        self.delegate = self
        self.viewControllers = [homeNavigationController,taskNavigationController,goalNavController, meNavigationController]
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
