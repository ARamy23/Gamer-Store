//
//  UITableView + Extensions.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
    /// Register UITableViewCell with .xib file using only its corresponding class.
    /// Assumes that the .xib filename and cell class has the same name.
    ///
    /// - Parameters:
    ///   - name: UITableViewCell type.
    ///   - bundleClass: Class in which the Bundle instance will be based on.
    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?
        
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        
        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
    /// Dequeue reusable UITableViewCell using class name
    ///
    /// - Parameter name: UITableViewCell type
    /// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }
}
