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
    
    lazy var searchController: UISearchController = {

        let searchController = UISearchController(searchResultsController: nil)

        searchController.searchBar.placeholder = "Search for the games"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.delegate = self

       return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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

extension GamesFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // The numbers here are used according to the given design
        return CGSize(width: collectionView.frame.width, height: 136)
    }
}

extension GamesFeedViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        presentation.searchQueryDidChnage(searchText)
    }
}
