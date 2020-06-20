//
//  GameDetailsViewModel.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

final class GameDetailsViewModel: Codable {
    let id: String
    let title: String
    let description: String
    let imageURL: String
    let redditURL: String
    let websiteURL: String
    var isFavorite: Bool = false
    
    init(game: Game) {
        self.id = String(game.id ?? 0)
        self.title = game.name ?? ""
        self.description = game.description ?? ""
        self.imageURL = game.backgroundImage ?? ""
        self.redditURL = ""
        self.websiteURL = ""
    }
}
