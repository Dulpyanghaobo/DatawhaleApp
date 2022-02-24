//
//  RouterAction.swift
//  DatawhaleApp
//
//  Created by Hab Yang on 2022/2/24.
//

import Foundation

public protocol RouterAction {
    func makeRouterToViewController(isAnimated: Bool)
}
