//
//  PopCompatiable.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/16.
//

import Foundation

protocol PopCompatiable {
    
    static var operationQueue : OperationQueue {get set}

    func show()

    func dismiss()

}
