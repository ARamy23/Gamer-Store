//
//  System.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/21/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation
import UIKit.UIApplication

struct System: SystemProtocol {
    func canOpenURLExternally(url: String) -> Bool {
        guard let url = URL(string: url) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
    
    func openURLExternally(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
