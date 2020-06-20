//
//  FavoritesViewController.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak private var favoriteGamesCollectionView: UICollectionView!
    
    private let dataSource = GamesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func bind() {
//        presentation.title.bind = { [weak self] title in
//            guard let self = self else { return }
//            self.navigationItem.title = title
//        }
        
//        presentation.favorites.bind = { [weak self] games in
//            guard let self = self else { return }
//            self.dataSource.games = games
//            self.favoriteGamesCollectionView.reloadData()
//        }
    }
    
    private func setupUI() {
        setupCollectionView()
        setupNavigationBar()
    }
    
    private func setupCollectionView() {
        favoriteGamesCollectionView.register(nibWithCellClass: GamesFeedCollectionViewCell.self)
        favoriteGamesCollectionView.delegate = dataSource
        favoriteGamesCollectionView.dataSource = dataSource
        
//        dataSource.didSelectGame = { [weak self] indexPath in
//            guard let self = self else { return }
//            self.presentation.didSelectGame(at: indexPath)
//        }
    }
    
    private func setupNavigationBar() {
//        let numberOfFavorites = presentation.favorites.value?.count ?? 0
//        let titleNumber = numberOfFavorites > 0 ? "(\(numberOfFavorites))" : ""
//        title.value = titleNumber
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
