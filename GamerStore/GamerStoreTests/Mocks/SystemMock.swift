//
//  SystemMock.swift
//  GamerStoreTests
//
//  Created by Ahmed Ramy on 6/21/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation
@testable import GamerStore

final class SystemMock: SystemProtocol {
    var shouldOpenURL: Bool = false
    var didOpenURL: Bool = false
    var triedURL: String = ""
    
    func canOpenURLExternally(url: String) -> Bool {
        self.triedURL = url
        return shouldOpenURL
    }
    
    func openURLExternally(url: String) {
        self.triedURL = url
        didOpenURL = true
    }
}
