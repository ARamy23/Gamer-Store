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
//        router.startActivityIndicator()
//        interactor.search(searchText) { [weak self] games in
//            guard let self = self else { return }
//            self.games.value = mapGamesToViewModels(games)
//            router.stopActivityIndicator()
//        }
    }
    
//    private func mapGamesToViewModels(_ games: [Game]) -> GameViewModel {
//        return []
//    }
    
    private func fetchGamesFeed() {
//        router.startActivityIndicator()
//        interactor.fetchGamesFeed { [weak self] games in
//            guard let self = self else { return }
//            self.games.value = mapGamesToViewModels()
//            router.stopActivityIndicator()
//        }
    }
}
