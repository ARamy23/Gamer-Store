//
//  FavoritesTests.swift
//  GamerStoreTests
//
//  Created by Ahmed Ramy on 6/21/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import XCTest
@testable import GamerStore

class FavoritesTests: BaseSceneTests {
    var sut: FavoritesPresentation!
    
    override func setUp() {
        super.setUp()
        sut = FavoritesPresentation(router: router, cache: cache)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testViewWillAppearWillShowFavoritesAreEmptyWhenThereAreNoFavoritesInCache() {
        // Given
        // Nothign
        
        // When
        sut.viewWillAppear()
        
        // Then
        XCTAssertTrue(sut.isFavoritesEmpty.value == true)
    }
    
    func testViewWillAppearWillShowFavoriteTitleWithoutNumbersWhenThereAreNowFavoritesInCache() {
        // Given
        // Nothign
        
        // When
        sut.viewWillAppear()
        
        // Then
        XCTAssertTrue(sut.title.value == "Favourites")
    }
    
    func testViewWillAppearWillShowFavoritesWhenThereAreFavoritesInCache() {
        // Given
        let dummyFavorites = [GameViewModel(), GameViewModel(), GameViewModel()]
        cache.saveObject(dummyFavorites, key: CachingKey.favorites.key)
        
        // When
        sut.viewWillAppear()
        
        // Then
        XCTAssertTrue(sut.title.value == "Favourites (\(dummyFavorites.count))")
    }
    
    func testViewWillAppearWillNotShowEmptyStateWhenThereAreFavoritesInCache() {
        // Given
        let dummyFavorites = [GameViewModel(), GameViewModel(), GameViewModel()]
        cache.saveObject(dummyFavorites, key: CachingKey.favorites.key)
        
        // When
        sut.viewWillAppear()
        
        // Then
        XCTAssertTrue(sut.isFavoritesEmpty.value == false)
    }
    
    func testWhenSwipesToDeleteThenAnAlertIsShownFirstBeforeDeleting() {
        // Given
        let dummyFavorites = [GameViewModel(), GameViewModel(), GameViewModel()]
        cache.saveObject(dummyFavorites, key: CachingKey.favorites.key)
        sut.viewWillAppear()
        
        // When
        sut.swipesToDelete(IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(router.actions.contains(.gaveAnAlert))
    }
    
    func testWhenSwipesToDeleteThenAnAlertIsShownThenSelectingToDeleteItDeletesTheGameFromFavoriteAndUpdateTheView() {
        // Given
        let toBeDeletedGame = GameViewModel()
        toBeDeletedGame.id = "1"
        let dummyFavorites = [toBeDeletedGame, GameViewModel(), GameViewModel()]
        cache.saveObject(dummyFavorites, key: CachingKey.favorites.key)
        sut.viewWillAppear()
        sut.swipesToDelete(IndexPath(row: 0, section: 0))
        
        // When
        router.alertActions.first(where: { $0.title == "Confirm" })?.action()
        
        // Then
        XCTAssertLessThan(sut.favorites.value?.count ?? 999, dummyFavorites.count)
    }
    
    func testDidSelectGameOpensGameDetails() {
        // Given
        let toBeOpenedFrom = GameViewModel()
        toBeOpenedFrom.id = "1"
        
        let dummyFavorites = [toBeOpenedFrom, GameViewModel(), GameViewModel()]
        cache.saveObject(dummyFavorites, key: CachingKey.favorites.key)
        sut.viewWillAppear()
        
        // When
        sut.didSelectGame(at: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(router.actions.contains(.push(GameDetailsViewController.self)))
    }
}
