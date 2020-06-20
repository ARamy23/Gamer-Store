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
    private let system: SystemProtocol
    
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
         cache: CacheProtocol = UserDefaultsManager(),
         system: SystemProtocol = System()) {
        self.game = game
        self.network = network
        self.cache = cache
        self.router = router
        self.system = system
    }
    
    func viewDidLoad() {
        let favoriteButtonTitle = isGameAlreadyFavorited ? "Favourited" : "Favourite"
        self.favoriteButtonTitle.value = favoriteButtonTitle
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
            newCacheFavourites.append(toBeCachedGame)
            cache.saveObject(newCacheFavourites, key: CachingKey.favorites.key)
            favoriteButtonTitle.value = "Favourited"
        }
    }
    
    private func openURL(_ urlString: String) {
        guard system.canOpenURLExternally(url: urlString) else {
            showAlert(AppMessages.GameDetails.couldntOpenURL.rawValue)
            return
        }
        
        system.openURLExternally(url: urlString)
    }
    
    private func showAlert(_ message: String) {
        router.alert(title: "Error", message: message, actions: [("Ok", .default)])
    }
}
