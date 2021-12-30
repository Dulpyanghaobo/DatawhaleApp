//
//  Pop.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/16.
//

import Foundation

public class Pop : PopCompatiable {
    static var operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.datawhale.pop.operationQueue"
        return queue
    }()

    public class func latestDismiss() {
        operationQueue.operations.last?.cancel()
    }

    public class func dismissAll() {
        operationQueue.cancelAllOperations()
    }

    func show() {

    }

    func dismiss() {

    }


}
