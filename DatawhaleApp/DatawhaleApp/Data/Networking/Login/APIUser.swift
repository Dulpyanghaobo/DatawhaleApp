//
//  APIUser.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/30.
//

import Foundation
import Moya
// 用户模块的api  仅仅做多业务拆分的演示。 具体网络请求接口封装可以参照API.swift文件
enum APIUser {
    case getInfo
    case updateUserInfo
}


extension APIUser: TargetType {
    var baseURL: URL {
        return URL.init(string:(Moya_baseURL))!
    }
    
    var path: String {
        switch self {
        case .getInfo:
            return "api/getInfo"
        case .updateUserInfo:
            return "api/updateUserInfo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getInfo, .updateUserInfo:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getInfo, .updateUserInfo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
    
}
