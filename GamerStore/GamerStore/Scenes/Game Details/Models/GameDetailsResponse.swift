//
//  GameDetailsResponse.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

// MARK: - GameDetails
struct GameDetails: Codable {
    let id: Int?
    let name, gameDetailsDescription: String?
    let backgroundImage: String?
    let website: String?
    let redditURL: String?
    let descriptionRaw: String?
    let metacritic: Int?
    let genres: [Genre]

    init() {
        self.id = 0
        self.name = ""
        self.gameDetailsDescription = ""
        self.backgroundImage = ""
        self.website = ""
        self.redditURL = ""
        self.descriptionRaw = ""
        self.metacritic = 0
        self.genres = []
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case gameDetailsDescription = "description"
        case backgroundImage = "background_image"
        case website
        case redditURL = "reddit_url"
        case descriptionRaw = "description_raw"
        case metacritic
        case genres
    }
}
