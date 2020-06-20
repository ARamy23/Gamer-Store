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

extension GamesDataSource: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: GamesFeedCollectionViewCell.self, for: indexPath)
        let game = games[indexPath.item]
        cell.configure(with: game)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectGame?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        didDisplayGame?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // The numbers here are used according to the given design
        return CGSize(width: collectionView.frame.width, height: 136)
    }
}
