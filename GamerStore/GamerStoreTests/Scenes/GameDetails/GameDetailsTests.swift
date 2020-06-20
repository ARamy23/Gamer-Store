//
//  GameDetailsTests.swift
//  GamerStoreTests
//
//  Created by Ahmed Ramy on 6/21/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import XCTest
@testable import GamerStore

class GameDetailsTests: BaseSceneTests {

    var sut: GameDetailsPresentation!
    
    override func setUp() {
        super.setUp()
        let testViewModel = GameDetailsViewModel()
        sut = GameDetailsPresentation(game: testViewModel, router: router, network: network, cache: cache)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
