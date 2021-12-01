//
//  User.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/29.
//

import Foundation
import ObjectMapper

class User: Mappable {
    func mapping(map: Map) {
        id <- map["title"]
        name <- map["name"]
        password <- map["password"]
    }
    
    required init?(map: Map) {}

    var id : String = ""
    var name : String = ""
    var password : String = ""
    
}
