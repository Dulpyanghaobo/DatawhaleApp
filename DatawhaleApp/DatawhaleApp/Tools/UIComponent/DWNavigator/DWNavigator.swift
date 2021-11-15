//
//  DWNavigator.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/15.
//

import Foundation

struct DWNavigator
{
    static func keyWindow() -> UIWindow {

        for window in UIApplication.shared.windows {
            if window.windowLevel == .normal {
                return window
            }
        }
        return UIWindow.init(frame: CGRect.init(x: 0, y: 0, width: DWScreenWidth, height: DWScreenHeight))
    }
}
