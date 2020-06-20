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
        sut = GameDetailsPresentation(game: testViewModel, router: router, network: network, cache: cache, system: system)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testViewDidLoadShowsGameIsFavouritedWhenItIsFavouritedBefore() {
        // Given
        let dummyCachedGameViewModel = GameViewModel()
        dummyCachedGameViewModel.id = "1"
        cache.saveObject([dummyCachedGameViewModel], key: CachingKey.favorites.key)
        
        let dummyCachedGameDetailsViewModel = GameDetailsViewModel()
        dummyCachedGameDetailsViewModel.id = "1"
        sut = GameDetailsPresentation(game: dummyCachedGameDetailsViewModel, router: router, network: network, cache: cache, system: system)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.favoriteButtonTitle.value ?? "", "Favourited")
    }
    
    func testViewDidLoadShowsGameIsYetToBeFavourtedWhenItIsNotFavouritedBefore() {
        // Given
        // Nothing
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.favoriteButtonTitle.value ?? "", "Favourite")
    }
    
    func testTapReadMoreWhenUserIsViewingPartOfTheDescription() {
        // Given
        // nothing
        
        // When
        sut.didTapReadMore()
        
        // Then
        XCTAssertEqual(sut.descriptionNumberOfLines.value ?? -1, 0)
        XCTAssertEqual(sut.readMoreButtonTitle.value ?? "", "Read Less")
    }
    
    func testTapReadMoreWhenUserIsViewingAllOfTheDescription() {
        // Given
        sut.didTapReadMore()
        
        // When
        sut.didTapReadMore()
        
        // Then
        XCTAssertEqual(sut.descriptionNumberOfLines.value ?? -1, 4)
        XCTAssertEqual(sut.readMoreButtonTitle.value ?? "", "Read More")
    }
    
    func testDidTapVisitRedditOpensURLInNormalCircumstances() {
        // Given
        system.shouldOpenURL = true
        
        // When
        sut.didTapVisitReddit()
        
        // Then
        XCTAssertTrue(system.didOpenURL)
    }
    
    func testDidTapVisitRedditWhenFailsToOpenURLItShowsAnAlert() {
        // Given
        system.shouldOpenURL = false
        
        // When
        sut.didTapVisitReddit()
        
        // Then
        XCTAssertTrue(!system.didOpenURL)
        XCTAssertTrue(router.actions.contains(.gaveAnAlert))
    }
    
    func testDidTapVisitWebsiteOpensURLInNormalCircumstances() {
        // Given
        system.shouldOpenURL = true
        
        // When
        sut.didTapVisitWebsite()
        
        // Then
        XCTAssertTrue(system.didOpenURL)
    }
    
    func testDidTapVisitWebsiteWhenFailsToOpenURLItShowsAnAlert() {
        // Given
        system.shouldOpenURL = false
        
        // When
        sut.didTapVisitWebsite()
        
        // Then
        XCTAssertTrue(!system.didOpenURL)
        XCTAssertTrue(router.actions.contains(.gaveAnAlert))
    }
    
    func testDidTapFavoriteDeletesGameFromFavoritesIfItsAlreadyThere() {
        // Given
        let dummyCachedGameViewModel = GameViewModel()
        dummyCachedGameViewModel.id = "1"
        cache.saveObject([dummyCachedGameViewModel], key: CachingKey.favorites.key)
        
        let dummyCachedGameDetailsViewModel = GameDetailsViewModel()
        dummyCachedGameDetailsViewModel.id = "1"
        sut = GameDetailsPresentation(game: dummyCachedGameDetailsViewModel, router: router, network: network, cache: cache, system: system)
        
        sut.viewDidLoad()
        
        // When
        sut.didTapFavorite()
        
        // Then
        let favoriteGamesInCache = cache.getObject([GameViewModel].self, key: CachingKey.favorites.key)
        XCTAssert(favoriteGamesInCache == nil || favoriteGamesInCache?.isEmpty == true)
        XCTAssertEqual(sut.favoriteButtonTitle.value, "Favourite")
    }
    
    func testDidTapFavoriteSavesGameFromFavoritesIfItsNotAlreadyThere() {
        // Given
        let dummyCachedGameDetailsViewModel = GameDetailsViewModel()
        dummyCachedGameDetailsViewModel.id = "1"
        sut = GameDetailsPresentation(game: dummyCachedGameDetailsViewModel, router: router, network: network, cache: cache, system: system)
        
        sut.viewDidLoad()
        
        // When
        sut.didTapFavorite()
        
        // Then
        let favoriteGamesInCache = cache.getObject([GameViewModel].self, key: CachingKey.favorites.key)
        XCTAssert(favoriteGamesInCache != nil && favoriteGamesInCache?.isEmpty == false)
        XCTAssertEqual(sut.favoriteButtonTitle.value, "Favourited")
    }
}
