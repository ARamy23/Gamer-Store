//
//  GamesDataSource.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UICollectionView

final class GamesDataSource: NSObject {
    var games: [GameViewModel] = []
    var didSelectGame: ((IndexPath) -> Void)?
    var didDisplayGame: ((IndexPath) -> Void)?
}

extension GamesDataSource: UITableViewDelegate, UITableViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: GamesFeedTableViewCell.self)
        let game = games[indexPath.item]
        cell.configure(with: game)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectGame?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        didDisplayGame?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
}
