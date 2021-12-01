//
//  APILogin.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/29.
//

import Foundation
import Moya

enum APILogin {
    case login(params : [String:String])
    case register(params : [String:String])
    case updatePassword(params : [String : String])
    case sendMobileMsg(phoneNumber : String)
}


extension APILogin: TargetType {
    var baseURL: URL {
        return URL.init(string:(Moya_baseURL))!
    }
    
    var path: String {
        switch self {
        case .login:
            return "addUser"
        case .register:
            return "register"
        case .updatePassword:
            return "updatePassword"
        case .sendMobileMsg(let phoneNumber):
            return "api/sendMobileMsg/\(phoneNumber)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .register,.updatePassword, .sendMobileMsg(_):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let params), .register(let params),.updatePassword(let params):
            // 默认按照Json进行编码
            return .requestParameters(parameters: ["id":params["Id"] as! String,"name":params["name"]as! String,"password":params["password"]as! String], encoding: JSONEncoding.default)
        case .sendMobileMsg(phoneNumber: _):
            return .requestPlain
            
        }
  
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
    
}
