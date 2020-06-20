//
//  GameDetailsPresentation.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation
import UIKit.UIApplication

final class GameDetailsPresentation {
    
    var readMoreButtonTitle = Dynamic<String>("Read More")
    var descriptionNumberOfLines = Dynamic<Int>(4)
    var favoriteButtonTitle = Dynamic<String>("Favourite")
    
    private let network: NetworkProtocol
    private let cache: CacheProtocol
    private let game: GameDetailsViewModel
    private let router: RouterProtocol
    
    private var shouldShowAllOfDescription: Bool = false
    
    private var cachedFavorites: [GameViewModel]? {
        return cache.getObject([GameViewModel].self, key: CachingKey.favorites.key)
    }
    
    private var isGameAlreadyFavorited: Bool {
        return cachedFavorites != nil && (cachedFavorites ?? []).contains(where: { $0.id == game.id })
    }
    
    init(game: GameDetailsViewModel,
         router: RouterProtocol,
         network: NetworkProtocol = URLSessionManager(),
         cache: CacheProtocol = UserDefaultsManager()) {
        self.game = game
        self.network = network
        self.cache = cache
        self.router = router
        self.setupInitialState()
    }
    
    func didTapReadMore() {
        shouldShowAllOfDescription.toggle()
        descriptionNumberOfLines.value = (shouldShowAllOfDescription) ? 0 : 4
        readMoreButtonTitle.value = (shouldShowAllOfDescription) ? "Read Less" : "Read More"
    }
    
    func didTapVisitReddit() {
        openURL(game.redditURL)
    }
    
    func didTapVisitWebsite() {
        openURL(game.websiteURL)
    }
    
    func didTapFavorite() {
        if isGameAlreadyFavorited {
            var newCacheFavorites = cachedFavorites ?? []
            newCacheFavorites.removeAll(where: { $0.id == game.id })
            cache.saveObject(newCacheFavorites, key: CachingKey.favorites.key)
            favoriteButtonTitle.value = "Favourite"
        } else {
            var newCacheFavourites = cachedFavorites ?? []
            let toBeCachedGame = GameViewModel(game: game)
            if let index = newCacheFavourites.firstIndex(where: { $0.id == game.id }) {
                newCacheFavourites[index] = toBeCachedGame
            } else {
                newCacheFavourites.append(toBeCachedGame)
                cache.saveObject([toBeCachedGame], key: CachingKey.favorites.key)
            }
            favoriteButtonTitle.value = "Favourited"
        }
    }
    
    private func setupInitialState() {
        let favoriteButtonTitle = isGameAlreadyFavorited ? "Favourited" : "Favourite"
        self.favoriteButtonTitle.value = favoriteButtonTitle
    }
    
    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            showAlert(NetworkError.somethingWentWrong)
            return
        }
        
        guard UIApplication.shared.canOpenURL(url) else {
            showAlert(NetworkError.somethingWentWrong)
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func showAlert(_ error: Error) {
        router.alert(title: "Error", message: error.localizedDescription, actions: [("Ok", .default)])
    }
}
