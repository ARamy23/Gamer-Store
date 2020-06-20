//
//  GamesFeedTableViewCell.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

class GamesFeedTableViewCell: UITableViewCell {

    @IBOutlet weak private var gameCoverImageView: UIImageView!
    @IBOutlet weak private var gameTitleLabel: UILabel!
    @IBOutlet weak private var gameMetacriticLabel: UILabel!
    @IBOutlet weak private var gameGenresLabel: UILabel!
    
    func configure(with game: GameViewModel) {
        self.gameCoverImageView.setImageWith(game.imageURL)
        self.gameTitleLabel.text = game.title
        self.gameMetacriticLabel.text = String(game.metacritic)
        self.gameGenresLabel.text = game.genres
        self.backgroundColor = game.didOpenBefore ? GSColor.selectedGray.color : GSColor.white.color
    }
}
