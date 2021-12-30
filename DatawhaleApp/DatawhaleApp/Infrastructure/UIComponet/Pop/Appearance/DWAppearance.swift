//
//  DWAppearance.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/14.
//

import UIKit

protocol DWAppearance : AnyObject {
    
    static var shared: Self { get set }
    init()

    // 背景颜色
    var backgroundColor : UIColor {get set}

}
