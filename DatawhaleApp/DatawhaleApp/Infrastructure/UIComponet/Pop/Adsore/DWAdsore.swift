//
//  DWAdsore.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/16.
//

import UIKit

protocol DWAdsore: AnyObject {

    static var shared : Self {get set}

    var isAdsore : Bool {get set}
    // X，y轴中心点偏移量
    var pointOffset : CGPoint {get set}
    
    init()


}
