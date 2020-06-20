//
//  AppMessages.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

enum AppMessages {
    enum GamesFeed: String {
        case couldntRefresh = "Couldn't Refresh Feed, Please try again later..."
        case couldntFindQuery = "No game has been searched"
        case coudlntFetchGameDetails = "Couldn't Open Game Details, please try again later"
        case couldntFetchGamesFeed = "Couldn't Fetch Games Feed, Please try again later"
    }
    
    enum Favorites: String {
        case noFavoritesFound = "There are no favourites found."
    }
}
