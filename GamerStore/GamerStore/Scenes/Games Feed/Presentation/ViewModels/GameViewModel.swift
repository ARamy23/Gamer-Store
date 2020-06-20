//
//  GameViewModel.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

class GameViewModel: Codable {
    var id: String
    let title: String
    let metacritic: Int
    let genres: String
    let imageURL: String
    var description: String?
    var redditURL: String?
    var websiteURL: String?
    
    var didOpenBefore: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case metacritic
        case genres
        case imageURL
        case description
        case redditURL
        case websiteURL
    }
    
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
    
    init() {
        self.id = ""
        self.title = ""
        self.metacritic = 0
        self.genres = ""
        self.imageURL = ""
        self.description = ""
        self.redditURL = ""
        self.websiteURL = ""
    }
}
