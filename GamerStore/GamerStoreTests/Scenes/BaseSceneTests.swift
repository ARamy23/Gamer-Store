//
//  BaseSceneTests.swift
//  GamerStoreTests
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import XCTest
@testable import GamerStore

class BaseSceneTests: XCTestCase {
    var network: NetworkMock!
    var cache: CacheMock!
    var router: RouterMock!
    var system: SystemMock!
    override func setUp() {
        super.setUp()
        self.network = NetworkMock()
        self.cache = CacheMock()
        self.router = RouterMock()
        self.system = SystemMock()
    }
    
    override func tearDown() {
        super.tearDown()
        self.network = nil
        self.cache = nil
        self.router = nil
        self.system = nil
    }
}
