//
//  GameDetailsViewController.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

class GameDetailsViewController: UIViewController {

    @IBOutlet weak var gameCoverImageView: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    
    var game: GameViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func setupUI() {
        setupViewData()
        setupNavigationBar()
    }
    
    private func setupViewData() {
        gameCoverImageView.setImageWith(game?.imageURL, #imageLiteral(resourceName: "xbox-283116_1920"))
        gameTitleLabel.text = game?.title
//        gameDescriptionLabel.text = game?.description
        gameDescriptionLabel.numberOfLines = 4
    }
    
    private func setupNavigationBar() {
        let favoriteButton = UIBarButtonItem(title: "Favourite", style: .plain, target: self, action: #selector(didTapFavorite))
        navigationItem.rightBarButtonItem = favoriteButton
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func bind() {
//        presentation.readMoreButtonTitle.bind = { [weak self] title in
//            guard let self = self else { return }
//            self.readMoreButton.setTitle(title, for: .normal)
//        }
        
//        presentation.description.bind = { [weak self] (text, numberOfLines) in
//            guard let self = self else { return }
//            self.gameDescriptionLabel.text = text
//            gameDescriptionLabel.numberOfLines = numberOfLines
//        }
    }
    
    @IBAction private func didTapReadMore() {
        // presentation.didTapReadMore()
    }
    
    @IBAction private func didTapVisitReddit() {
        // presentation.didTapVisitReddit()
    }
    
    @IBAction private func didTapVisitWebsite() {
        // presentation.didTapVisitWebsite()
    }
    
    @objc private func didTapFavorite() {
        // presentation.didTapFavorite()
    }
}
