//
//  Game.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

// MARK: - GamesFeedResponse
struct GamesFeedResponse: Codable {
    let results: [Game]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct Game: Codable {
    let id: Int?
    let name: String?
    let backgroundImage: String?
    let metacritic: Int?
    let genres: [Genre]?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case backgroundImage = "background_image"
        case metacritic
        case genres
        case description
    }
    
    init() {
        self.id = 0
        self.name = ""
        self.backgroundImage = ""
        self.metacritic = 0
        self.genres = []
        self.description = ""
    }
}

// MARK: - Genre
struct Genre: Codable {
    let name: String?
}
