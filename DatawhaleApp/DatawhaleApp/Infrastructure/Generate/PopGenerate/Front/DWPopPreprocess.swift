//
//  Preprocess.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/16.
//

import Foundation

// 处理原始弹窗信息-> 将原始弹窗重新组装
// 对未来弹窗进行解析重组-> 对未来弹窗进行兼容
// 支持自定义弹窗
// AOP
class DWPopPreprocess {
    static let shared : DWPopPreprocess = .init()
    private init() {}
}
