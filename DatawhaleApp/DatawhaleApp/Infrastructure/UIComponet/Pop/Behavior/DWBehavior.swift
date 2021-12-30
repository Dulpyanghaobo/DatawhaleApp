//
//  Behavior.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/13.
//

import Foundation

protocol DWBehavior : AnyObject {
    
    static var shared : Self {get set}

    init()
    // 是否点击之后消失
    var isTappedDismissEnabled: Bool { get set }
    // 延迟展示
    var delay: TimeInterval { get set }
    // 展示时间
    var showDurarion: TimeInterval { get set }
    // 消失时间
    var dismissDuration: TimeInterval { get set }
    // 展示动画
    var animator : DWAnimator {get set}
}
