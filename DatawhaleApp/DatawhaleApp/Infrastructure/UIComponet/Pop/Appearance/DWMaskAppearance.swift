//
//  DWMaskAppearance.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/16.
//

import UIKit

public final class DWMaskAppearance: DWAppearance {

    init() {

    }

    static var shared: DWMaskAppearance = .init()

    var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.2)

}
