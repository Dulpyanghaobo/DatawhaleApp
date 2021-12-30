//
//  UITableViewExtensions.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/30.
//

import UIKit

public protocol TableViewReusable { }

extension TableViewReusable {
  fileprivate static var identifier: String {
    return String(describing: type(of: self))
  }
}

extension UITableView {
  /// 注册Cell或者Cell子类
  public func register<T: UITableViewCell & TableViewReusable>(_ cellClass: T.Type) {
    register(cellClass, forCellReuseIdentifier: cellClass.identifier)
  }
  /// 注册RegisterHeaderFooter或者他的子类
  public func registerHeaderFooter<T: UITableViewHeaderFooterView & TableViewReusable>(_ headerFooterClass: T.Type) {
    register(headerFooterClass, forHeaderFooterViewReuseIdentifier: headerFooterClass.identifier)
  }
  // 读取缓冲区当中的Cell
  public func dequeueReusableCell<T: UITableViewCell & TableViewReusable>(for indexPath: IndexPath) -> T {
    return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
  }
  // 读取缓冲区当中的HeaderFooter
  public func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView & TableViewReusable>() -> T {
    return dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as! T
  }

}
