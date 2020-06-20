//
//  GamesFeedTests.swift
//  GamerStoreTests
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import XCTest
@testable import GamerStore

class GamesFeedTests: BaseSceneTests {
    
    var sut: GamesFeedPresentation!
    
    override func setUp() {
        super.setUp()
        sut = GamesFeedPresentation(router: router,
                                    network: network,
                                    cache: cache)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testViewDidLoadFetchesGamesFeedFromRemoteFirstTimeAppLaunchesThenSavesItForFutureUse() {
        // Given
        let dummyGames: [Game] = (1...10).map { _ -> Game in
            return Game()
        }
        
        network.expectedObject = GamesFeedResponse(results: dummyGames)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(!network.calledAPIs.isEmpty)
        XCTAssertTrue(cache.didCacheSomething)
    }
    
    func testViewDidLoadFetchesGamesFromCacheSecondTimeAppLaunches() {
        // Given
        let dummyGames: [Game] = (1...10).map { _ -> Game in
            return Game()
        }
        
        network.expectedObject = GamesFeedResponse(results: dummyGames)
        sut.viewDidLoad()
        
        XCTAssertFalse(cache.didFetchFromCache)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertFalse(cache.didFetchFromCache)
        XCTAssertEqual(network.calledAPIs.count, 1)
    }
    
    func testViewDidLoadShowsAlertWhenRequestFailsFirstTime() {
        // Given
        network.expectedError = NetworkError.somethingWentWrong
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(router.actions.contains(.gaveAnAlert))
        XCTAssertTrue(router.actions.contains(.alert(AppMessages.GamesFeed.couldntFetchGamesFeed.rawValue)))
    }
    
    func testPagination() {
         // Given
        let dummyGames: [Game] = (1...10).map { _ -> Game in
            return Game()
        }
        
        network.expectedObjects = [GamesFeedResponse(results: dummyGames), GamesFeedResponse(results: dummyGames)]
        sut.viewDidLoad()
        
        // When
        sut.prefetchGames(at: IndexPath(row: 7, section: 0))
        
        // Then
        XCTAssertGreaterThan(sut.games.value?.count ?? 0, dummyGames.count)
        XCTAssertEqual(network.calledAPIs.count, 2)
    }
    
    func testRefreshFeedResetsGamesToOnePage() {
        // Given
        let dummyGames: [Game] = (1...10).map { _ -> Game in
            return Game()
        }
        
        network.expectedObjects = [GamesFeedResponse(results: dummyGames), GamesFeedResponse(results: dummyGames), GamesFeedResponse(results: dummyGames)]
        sut.viewDidLoad()
        sut.prefetchGames(at: IndexPath(row: 7, section: 0))
        
        // When
        sut.refreshFeed()
        
        // Then
        XCTAssertEqual(sut.games.value?.count ?? 0, dummyGames.count)
    }
    
    func testRefreshFeedShowsAlertWhenItFails() {
        // Given
        let dummyGames: [Game] = (1...10).map { _ -> Game in
            return Game()
        }
        
        network.expectedObjects = [GamesFeedResponse(results: dummyGames), GamesFeedResponse(results: dummyGames)]
        sut.viewDidLoad()
        sut.prefetchGames(at: IndexPath(row: 7, section: 0))
        network.expectedError = NetworkError.somethingWentWrong
        
        // When
        sut.refreshFeed()
        
        // Then
        XCTAssertTrue(router.actions.contains(.gaveAnAlert))
        XCTAssertTrue(router.actions.contains(.alert(AppMessages.GamesFeed.couldntRefresh.rawValue)))
    }
    
    func testBeginningToSearchRemovesAllGamesFromView() {
        // Given
        let dummyGames: [Game] = (1...10).map { _ -> Game in
            return Game()
        }
        
        network.expectedObjects = [GamesFeedResponse(results: dummyGames)]
        sut.viewDidLoad()
        
        XCTAssertGreaterThan(sut.games.value?.count ?? 0, 0)
        
        // When
        sut.didBeginSearching()
        
        // Then
        XCTAssertEqual(sut.games.value?.count ?? -1, 0)
    }
    
    func testSearchingForSomethingThatIsLessThan3CharactersLongDoesNotWork() {
        // Given
        sut.didBeginSearching()
        
        // When
        sut.searchQueryDidChange("Gta")
        
        // Then
        XCTAssertTrue(network.calledAPIs.isEmpty)
    }
    
    func testSearchingForSomethingThatIsThereInTheRemoteDisplaysIt() {
        // Given
        sut.didBeginSearching()
        let dummyGames: [Game] = (1...10).map { _ -> Game in
            return Game()
        }
        
        network.expectedObjects = [GamesFeedResponse(results: dummyGames)]
        
        // When
        sut.searchQueryDidChange("GtaV")
        
        // Then
        XCTAssertTrue(!network.calledAPIs.isEmpty)
        XCTAssertGreaterThan(sut.games.value?.count ?? 0, 0)
    }
    
    func testPaginationWhenSearching() {
        // Given
        sut.didBeginSearching()
        let dummyGames: [Game] = (1...10).map { _ -> Game in
            return Game()
        }
        
        network.expectedObjects = [GamesFeedResponse(results: dummyGames), GamesFeedResponse(results: dummyGames)]
        sut.searchQueryDidChange("GtaV")
        
        // When
        sut.prefetchGames(at: IndexPath(row: 7, section: 0))
        
        // Then
        XCTAssertTrue(!network.calledAPIs.isEmpty)
        XCTAssertGreaterThan(sut.games.value?.count ?? 0, 10)
    }
    
    func testSearchingForSomethingAndRequestFailsThenAlertIsShown() {
        // Given
        sut.didBeginSearching()
        let dummyGames: [Game] = (1...10).map { _ -> Game in
            return Game()
        }
        
        network.expectedObjects = [GamesFeedResponse(results: dummyGames)]
        sut.searchQueryDidChange("GtaV")
        
        network.expectedError = NetworkError.somethingWentWrong
        
        // When
        sut.searchQueryDidChange("Atreus From God of War")
        
        // Then
        XCTAssertTrue(router.actions.contains(.gaveAnAlert))
        XCTAssertTrue(router.actions.contains(.alert(AppMessages.General.somethingWentWrong.rawValue)))
    }
    
    func testCancelingSearchResetsDataSourceThenRefresh() {
        // Given
        sut.didBeginSearching()
        let dummyGames: [Game] = (1...10).map { _ -> Game in
            return Game()
        }
        
        network.expectedObjects = [GamesFeedResponse(results: dummyGames)]
        sut.searchQueryDidChange("GtaV")
        
        // When
        sut.didCancelSearching()
        XCTAssertEqual(sut.games.value?.count ?? -1, 0)
        
        network.expectedObjects = [GamesFeedResponse(results: dummyGames)]
        sut.didCancelSearching()
        
        // Then
        XCTAssertTrue((network.calledAPIs.last?.parameters["page"] as? String) ?? "-1" == "1")
    }
    
    func testWhenSearchingForSomethingAndNothingIsFoundItShowsEmptySearchState() {
        // Given
        sut.didBeginSearching()
        
        network.expectedObjects = [GamesFeedResponse(results: [])]
        
        // When
        sut.searchQueryDidChange("GtaV")
        
        // Then
        XCTAssertTrue(sut.shouldShowNoGamesFound.value == true)
    }
    
    func testWhenClickingOnAGameItGoesToGameDetails() {
        // Given
        let dummyGames: [Game] = (1...10).map { _ -> Game in
            return Game()
        }
        
        network.expectedObjects = [GamesFeedResponse(results: dummyGames), GameDetails()]
        sut.viewDidLoad()
        
        // When
        sut.didSelectGame(at: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(router.actions.contains(.push(GameDetailsViewController.self)))
    }
    
    func testWhenClickingOnAGameAndItFailsToFetchGameDetailsThenAlertIsShown() {
        // Given
        let dummyGames: [Game] = (1...10).map { _ -> Game in
            return Game()
        }
        
        network.expectedObjects = [GamesFeedResponse(results: dummyGames)]
        sut.viewDidLoad()
        
        network.expectedError = NetworkError.somethingWentWrong
        
        // When
        sut.didSelectGame(at: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(!router.actions.contains(.push(GameDetailsViewController.self)))
        XCTAssertTrue(router.actions.contains(.gaveAnAlert))
        XCTAssertTrue(router.actions.contains(.alert(AppMessages.GamesFeed.coudlntFetchGameDetails.rawValue)))
    }
}
