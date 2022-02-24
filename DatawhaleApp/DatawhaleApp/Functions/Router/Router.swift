//
//  Router.swift
//  DatawhaleApp
//
//  Created by Hab Yang on 2022/2/24.
//

import Foundation

protocol RouterObject {
    func showViewController(type:RouterType, animated: Bool)
}

public enum RouterType {
    case Home
    case Result
    case Camera
}

struct Router {
    
    let routerFactor: RouterFactor = RouterFactor.shared
    
    func configRouter(router: [String: RouterObject]) {
        routerFactor.routerList
    }
}




