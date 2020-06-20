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

    enum CodingKeys: String, CodingKey {
        case id, name
        case gameDetailsDescription = "description"
        case backgroundImage = "background_image"
        case website
        case redditURL = "reddit_url"
        case descriptionRaw = "description_raw"
    }
}
