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
    
    private lazy var router: RouterProtocol = {
        let router = Router()
        router.presentedView = self
        return router
    }()
    
    private lazy var presentation = FavoritesPresentation(router: self.router)
    
    private let dataSource = GamesDataSource()
    
    private lazy var emptyStateView: UIViewController = {
        return EmptyStateViewController(.favorites)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        presentation.viewDidLoad()
    }
    
    private func bind() {
        presentation.title.bind = { [weak self] title in
            guard let self = self else { return }
            self.navigationItem.title = title
        }
        
        presentation.favorites.bind = { [weak self] games in
            guard let self = self else { return }
            self.dataSource.games = games
            self.favoriteGamesCollectionView.reloadData()
        }
        
        presentation.isFavoritesEmpty.bind = { [weak self] isEmpty in
            guard let self = self else { return }
            self.favoriteGamesCollectionView.backgroundView = (isEmpty) ? self.emptyStateView.view : nil
        }
    }
    
    private func setupUI() {
        setupCollectionView()
        setupNavigationBar()
    }
    
    private func setupCollectionView() {
        favoriteGamesCollectionView.register(nibWithCellClass: GamesFeedCollectionViewCell.self)
        favoriteGamesCollectionView.delegate = dataSource
        favoriteGamesCollectionView.dataSource = dataSource
        
        dataSource.didSelectGame = { [weak self] indexPath in
            guard let self = self else { return }
            self.presentation.didSelectGame(at: indexPath)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
