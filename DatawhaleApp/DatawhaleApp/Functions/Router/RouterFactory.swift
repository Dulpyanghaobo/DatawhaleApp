//
//  RouterFactory.swift
//  DatawhaleApp
//
//  Created by Hab Yang on 2022/2/24.
//

import Foundation
import UIKit

class RouterFactor {
    
    static let shared = RouterFactor()
    
    var routerDic: [String: RouterObject]?
    
    var routerList: [[String: RouterObject]?]?
}
