//
//  UITableViewExtensions.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/6/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

extension UITableView {
    public func register(_ cellClass: UITableViewCell.Type) {
        let className = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: className)
    }
    
    public func registerNib(_ cellClass: UITableViewCell.Type) {
        let className = String(describing: cellClass)
        register(UINib(nibName: className, bundle: nil),
                 forCellReuseIdentifier: className)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        let className = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: className, for: indexPath) as! T
    }
}

