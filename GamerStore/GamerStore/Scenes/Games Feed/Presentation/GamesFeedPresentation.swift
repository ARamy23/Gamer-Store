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
                case .failure:
                    self.showAlert(AppMessages.GamesFeed.couldntRefresh.rawValue)
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
                case .failure:
                    self.showAlert(AppMessages.GamesFeed.couldntFindQuery.rawValue) // TODO: - Notify The view that search query was not found
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
        router.startActivityIndicator()
        let game = (games.value ?? [])[indexPath.item]
        let gameID = game.id
        GameDetailsFetcher(gameID: gameID, network: network).fetchGameDetails { [weak self] results in
            guard let self = self else { return }
            self.router.stopActivityIndicator()
            switch results {
            case .success(let gameDetails):
                self.cache.saveObject(game, key: CachingKey.seenGame(gameID).key)
                game.didOpenBefore = true
                self.games.value?[indexPath.item] = game
                let vc = Storyboard.GamesFeed.viewController(GameDetailsViewController.self)
                let gameViewModel = GameDetailsViewModel(game: gameDetails)
                vc.game = gameViewModel
                self.router.push(view: vc)
            case .failure:
                self.showAlert(AppMessages.GamesFeed.coudlntFetchGameDetails.rawValue)
            }
        }
    }
    
    private func mapGamesToViewModels(_ games: [Game]) -> [GameViewModel] {
        return games.map {
            let viewModel = GameViewModel(game: $0)
            viewModel.didOpenBefore = self.cache.getObject(GameViewModel.self, key: CachingKey.seenGame(viewModel.id).key) != nil
            return viewModel
        }
    }
    
    private func showAlert(_ message: String) {
        self.router.alert(title: "Error",
                          message: message,
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
                    
                case .failure:
                    self.showAlert(AppMessages.GamesFeed.couldntFetchGamesFeed.rawValue)
                }
        }
    }
}
