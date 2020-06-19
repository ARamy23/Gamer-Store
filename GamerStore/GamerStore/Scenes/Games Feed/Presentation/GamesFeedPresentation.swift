//
//  GamesFeedPresentation.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

final class GamesFeedPresentation {
    var games = Dynamic<[GameViewModel]>([])
    
    private let network: NetworkProtocol
    private let router: RouterProtocol
    private let cache: CacheProtocol
    
    private var hasReachedEndOfGames: Bool = false
    private var isPrefetching: Bool = false
    
    private var pagination: PaginationDetails = (pageSize: 10, page: 1)
    
    init(router: RouterProtocol,
         network: NetworkProtocol = URLSessionManager(),
         cache: CacheProtocol = UserDefaultsManager()) {
        self.network = network
        self.router = router
        self.cache = cache
    }
    
    func viewDidLoad() {
        fetchGamesFeed()
    }
    
    func refreshFeed() {
        pagination = (10, 1)
        GamesFeedFetcher(pagination: pagination, network: network, cache: cache)
            .refreshGamesFeed { (results) in
                switch results {
                case let .success(games):
                    self.games.value = self.mapGamesToViewModels(games)
                case let .failure(error):
                    self.showAlert(error)
                }
        }
    }
    
    func searchQueryDidChnage(_ searchText: String) {
        guard searchText.count > 3 else { return }
        router.startActivityIndicator()
        GamesSearcher(query: searchText,
                      pagination: pagination,
                      network: network)
            .search { [weak self] results in
                guard let self = self else { return }
                self.router.stopActivityIndicator()
                switch results {
                case let .success(games):
                    self.games.value = self.mapGamesToViewModels(games)
                case let .failure(error):
                    self.showAlert(error)
                }
                
                
        }
    }
    
    /// Prefetches games before user reaches the end of page for enhanced UX
    /// - Parameter indexPath: current displayed game indexPath
    func prefetchGames(at indexPath: IndexPath) {
        
        let currentItemIndex = indexPath.item
        let prefetchingRange = 4
        let currentFetchedGamesTotalCount = games.value?.count ?? 0
        
        let shouldPrefetchAds = currentItemIndex >= currentFetchedGamesTotalCount - 1 - prefetchingRange
        
        if shouldPrefetchAds, !isPrefetching, !hasReachedEndOfGames {
            isPrefetching = true
            pagination.page += 1
            fetchGamesFeed()
        }
    }
    
    func didSelectGame(at indexPath: IndexPath) {
//        let vc = Storyboard.GamesFeed.viewController(GameDetailsViewController.self)
//        vc.game = games.value?[indexPath.item]
//        router.push(view: vc)
    }
    
    private func mapGamesToViewModels(_ games: [Game]) -> [GameViewModel] {
        return games.map { GameViewModel(game: $0) }
    }
    
    private func showAlert(_ error: Error) {
        self.router.alert(title: "Error",
                          message: error.localizedDescription,
                          actions: [("Ok", .default)])
    }
    
    private func fetchGamesFeed() {
        router.startActivityIndicator()
        GamesFeedFetcher(pagination: pagination,
                         network: network,
                         cache: cache)
            .fetchGamesFeed { [weak self] results in
                guard let self = self else { return }
                self.router.stopActivityIndicator()
                self.isPrefetching = false
                switch results {
                case .success(let games):
                    let currentDisplayedGames = self.games.value ?? []
                    let viewModels = self.mapGamesToViewModels(games)
                    
                    if currentDisplayedGames.isEmpty {
                        self.games.value = viewModels
                    } else {
                        self.games.value?.append(contentsOf: viewModels)
                    }
                    
                case .failure(let error):
                    self.showAlert(error)
                }
        }
    }
}
