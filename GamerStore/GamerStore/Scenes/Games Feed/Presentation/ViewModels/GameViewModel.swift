//
//  GameViewModel.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

struct GameViewModel: Codable {
    let id: String
    let title: String
    let metacritic: Int
    let genres: String
    let imageURL: String
    let description: String?
    let redditURL: String?
    let websiteURL: String?
    
    init(game: Game) {
        self.id = String(game.id ?? 0)
        self.title = game.name ?? ""
        self.metacritic = game.metacritic ?? 0
        self.genres = (game.genres ?? []).map { $0.name ?? "" }.joined(separator: ", ")
        self.imageURL = game.backgroundImage ?? ""
        self.description = nil
        self.redditURL = nil
        self.websiteURL = nil
    }
    
    init(game: GameDetailsViewModel) {
        self.id = game.id
        self.title = game.title
        self.metacritic = game.metacritic
        self.genres = game.genres
        self.imageURL = game.imageURL
        self.description = game.description
        self.redditURL = game.redditURL
        self.websiteURL = game.websiteURL
    }
}
