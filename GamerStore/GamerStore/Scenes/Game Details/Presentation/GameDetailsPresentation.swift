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
    
    private var isGameAlreadyFavorited: Bool {
        return cache.getObject(GameDetailsViewModel.self, key: CachingKey.favorites(game.id).key) != nil
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
    }
    
    func didTapVisitReddit() {
        openURL(game.redditURL)
    }
    
    func didTapVisitWebsite() {
        openURL(game.websiteURL)
    }
    
    func didTapFavorite() {
        if isGameAlreadyFavorited {
            cache.removeObject(key: CachingKey.favorites(game.id).key)
        } else {
            cache.saveObject(game, key: CachingKey.favorites(game.id).key)
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
