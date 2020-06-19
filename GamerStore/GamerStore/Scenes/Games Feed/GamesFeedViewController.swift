//
//  GamesFeedViewController.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

class GamesFeedViewController: UIViewController {

    @IBOutlet weak var gamesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        gamesCollectionView.register(nibWithCellClass: GamesFeedCollectionViewCell.self)
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
    }
}

extension GamesFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return presentation.games.value?.count
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: GamesFeedCollectionViewCell.self, for: indexPath)
//        let game = presentation.games.value?[indexPath.item]
//        cell.configure(from: game)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        presentation.didSelectGame(at: indexPath)
    }
}

