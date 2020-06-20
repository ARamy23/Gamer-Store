//
//  GameDetailsViewModel.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

final class GameDetailsViewModel: Codable {
    var id: String
    let title: String
    let description: String
    let metacritic: Int
    let imageURL: String
    let redditURL: String
    let websiteURL: String
    let genres: String
    
    init() {
        id = ""
        title = ""
        description = ""
        metacritic = 0
        imageURL = ""
        redditURL = ""
        websiteURL = ""
        genres = ""
    }
    
    init(game: GameDetails) {
        self.id = String(game.id ?? 0)
        self.title = game.name ?? ""
        self.description = game.descriptionRaw ?? ""
        self.imageURL = game.backgroundImage ?? ""
        self.redditURL = game.redditURL ?? ""
        self.websiteURL = game.website ?? ""
        self.metacritic = game.metacritic ?? 0
        self.genres = game.genres.map { $0.name ?? "" }.joined(separator: ", ")
    }
    
    init(game: GameViewModel) {
        guard let description = game.description,
            let redditURL = game.redditURL,
            let websiteURL = game.websiteURL else { fatalError("please don't use this init unless you have a these requirements, i.e.: coming from favorites")}
        self.id = game.id
        self.title = game.title
        self.description = description
        self.imageURL = game.imageURL
        self.genres = game.genres
        self.metacritic = game.metacritic
        self.redditURL = redditURL
        self.websiteURL = websiteURL
    }
}
