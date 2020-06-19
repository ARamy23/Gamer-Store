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
    
    func didSelectGame(at indexPath: IndexPath) {
//        let vc = Storyboard.GamesFeed.viewController(GameDetailsViewController.self)
//        vc.game = games.value?[indexPath.item]
//        router.push(view: vc)
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
                    self.router.alert(title: "Error",
                                      message: error.localizedDescription,
                                      actions: [("Ok", .default)])
                }
                
                
        }
    }
    
    private func mapGamesToViewModels(_ games: [Game]) -> [GameViewModel] {
        return games.map { GameViewModel(game: $0) }
    }
    
    private func fetchGamesFeed() {
//        router.startActivityIndicator()
//        interactor.fetchGamesFeed { [weak self] games in
//            guard let self = self else { return }
//            self.games.value = mapGamesToViewModels()
//            router.stopActivityIndicator()
//        }
    }
}
