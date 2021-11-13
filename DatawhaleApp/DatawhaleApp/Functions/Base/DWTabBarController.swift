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
//        let navigationController = DWNavigationController.init(rootViewController: <#T##UIViewController#>)
//        navigationController.tabBarItem;
//        let navigationController = DWNavigationController.init(rootViewController: <#T##UIViewController#>)
//        navigationController.tabBarItem;
//        let navigationController = DWNavigationController.init(rootViewController: <#T##UIViewController#>)
//        navigationController.tabBarItem;
        // Do any additional setup after loading the view.
        self.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
