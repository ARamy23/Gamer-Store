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
    
    private lazy var router: RouterProtocol = {
        let router = Router()
        router.presentedView = self
        return router
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)

        searchController.searchBar.placeholder = "Search for the games"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.delegate = self

       return searchController
    }()
    
    private lazy var presentation = GamesFeedPresentation(router: router)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        presentation.viewDidLoad()
    }
    
    private func bind() {
        presentation.games.bind = { [weak self] _ in
            guard let self = self else { return }
            self.gamesCollectionView.reloadData()
        }
    }
    
    private func setupUI() {
        setupGamesFeed()
        setupNavigationBar()
    }
    
    private func setupGamesFeed() {
        gamesCollectionView.register(nibWithCellClass: GamesFeedCollectionViewCell.self)
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
}

extension GamesFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presentation.games.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: GamesFeedCollectionViewCell.self, for: indexPath)
        let games = presentation.games.value ?? []
        let game = games[indexPath.item]
        cell.configure(with: game)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentation.didSelectGame(at: indexPath)
    }
}

extension GamesFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // The numbers here are used according to the given design
        return CGSize(width: collectionView.frame.width, height: 136)
    }
}

extension GamesFeedViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presentation.searchQueryDidChnage(searchText)
    }
}
