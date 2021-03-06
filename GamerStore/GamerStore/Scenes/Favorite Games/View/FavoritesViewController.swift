//
//  FavoritesViewController.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak private var favoriteGamesTableView: UITableView!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupUI()
        bind()
        presentation.viewWillAppear()
    }
    
    private func bind() {
        presentation.title.bind = { [weak self] title in
            guard let self = self else { return }
            self.navigationItem.title = title
        }
        
        presentation.favorites.bind = { [weak self] games in
            guard let self = self else { return }
            self.dataSource.games = games
            self.favoriteGamesTableView.reloadData()
        }
        
        presentation.isFavoritesEmpty.bind = { [weak self] isEmpty in
            guard let self = self else { return }
            self.favoriteGamesTableView.backgroundView = (isEmpty) ? self.emptyStateView.view : nil
        }
    }
    
    private func setupUI() {
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        favoriteGamesTableView.register(nibWithCellClass: GamesFeedTableViewCell.self)
        favoriteGamesTableView.delegate = dataSource
        favoriteGamesTableView.dataSource = dataSource
        favoriteGamesTableView.separatorStyle = .none
        dataSource.canEdit = true
        
        dataSource.didSelectGame = { [weak self] indexPath in
            guard let self = self else { return }
            self.presentation.didSelectGame(at: indexPath)
        }
        
        dataSource.swipesToDelete = { [weak self] indexPath in
            guard let self = self else { return }
            self.presentation.swipesToDelete(indexPath)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
