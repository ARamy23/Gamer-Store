//
//  GamesFeedViewController.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

class GamesFeedViewController: UIViewController {

    @IBOutlet weak var gamesTableView: UITableView!
    
    private lazy var router: RouterProtocol = {
        let router = Router()
        router.presentedView = self
        return router
    }()
    
    private let dataSource: GamesDataSource = GamesDataSource()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)

        searchController.searchBar.placeholder = "Search for the games"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.definesPresentationContext = true
        searchController.searchBar.delegate = self

       return searchController
    }()
    
    lazy var emptySearchView: EmptyStateViewController = {
        return EmptyStateViewController(.search)
    }()
    
    private lazy var presentation = GamesFeedPresentation(router: router)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        presentation.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func bind() {
        presentation.games.bind = { [weak self] games in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
            self.dataSource.games = games
            self.gamesTableView.reloadData()
        }
        
        presentation.shouldShowNoGamesFound.bind = { [weak self] shouldShowNoGamesFound in
            guard let self = self else { return }
            self.gamesTableView.backgroundView = shouldShowNoGamesFound ? self.emptySearchView.view : nil
        }
    }
    
    private func setupUI() {
        setupNavigationBar()
        setupGamesFeed()
    }
    
    private func setupGamesFeed() {
        gamesTableView.register(nibWithCellClass: GamesFeedTableViewCell.self)
        gamesTableView.delegate = dataSource
        gamesTableView.dataSource = dataSource
        gamesTableView.refreshControl = self.refreshControl
        gamesTableView.separatorStyle = .none
        
        dataSource.didSelectGame = { [weak self] indexPath in
            guard let self = self else { return }
            self.presentation.didSelectGame(at: indexPath)
        }
        
        dataSource.didDisplayGame = { [weak self] indexPath in
            guard let self = self else { return }
            self.presentation.prefetchGames(at: indexPath)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc private func refreshFeed() {
        presentation.refreshFeed()
    }
}

extension GamesFeedViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presentation.searchQueryDidChange(searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        presentation.didBeginSearching()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presentation.didCancelSearching()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presentation.searchQueryDidChange(searchBar.text ?? "")
    }
}
