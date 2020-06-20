//
//  FavoritesPresentation.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

final class FavoritesPresentation {
    let title = Dynamic<String>("Favourites")
    let favorites = Dynamic<[GameViewModel]>([])
    let isFavoritesEmpty = Dynamic<Bool>(true)
    
    private let cache: CacheProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, cache: CacheProtocol = UserDefaultsManager()) {
        self.cache = cache
        self.router = router
    }
    
    func viewWillAppear() {
        getFavoritesFromCache()
        setupNavigationTitle()
    }
    
    func didSelectGame(at indexPath: IndexPath) {
        let vc = Storyboard.GamesFeed.viewController(GameDetailsViewController.self)
        let gameViewModel = (favorites.value ?? [])[indexPath.item]
        let gameDetailsViewModel = GameDetailsViewModel(game: gameViewModel)
        vc.game = gameDetailsViewModel
        router.push(view: vc)
    }
    
    func swipesToDelete(_ indexPath: IndexPath) {
        let confirmAction: AlertAction = ("Confirm", .destructive, {
            var newCacheFavorites = self.favorites.value ?? []
            let game = newCacheFavorites[indexPath.row]
            newCacheFavorites.removeAll(where: { $0.id == game.id })
            self.cache.saveObject(newCacheFavorites, key: CachingKey.favorites.key)
            self.getFavoritesFromCache()
            self.setupNavigationTitle()
        })
        
        let cancelAction: AlertAction = ("Cancel", .cancel, { })
        router.alertWithAction(title: "Are you sure", message: "you want to remove this from your favourites?", alertStyle: .alert, actions: [confirmAction, cancelAction])
    }
    
    private func getFavoritesFromCache() {
        let cachedFavorites = cache.getObject([GameViewModel].self, key: CachingKey.favorites.key) ?? []
        favorites.value =  cachedFavorites
        isFavoritesEmpty.value = cachedFavorites.isEmpty
    }
    
    private func setupNavigationTitle() {
        let numberOfFavorites = self.favorites.value?.count ?? 0
        let titleNumber = numberOfFavorites > 0 ? "Favourites (\(numberOfFavorites))" : "Favourites"
        title.value = titleNumber
    }
}
