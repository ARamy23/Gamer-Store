//
//  GamesFeedCollectionViewCell.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit
import Kingfisher

class GamesFeedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gameCoverImageView: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var metacriticLabel: UILabel!
    
    func configure(with viewModel: GameViewModel) {
        downloadImage(viewModel)
        gameTitleLabel.text = viewModel.title
        genresLabel.text = viewModel.genres
        metacriticLabel.text = String(viewModel.metacritic)
    }
    
    private func downloadImage(_ viewModel: GameViewModel) {
        gameCoverImageView.setImageWith(viewModel.imageURL, #imageLiteral(resourceName: "xbox-283116_1920"))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameCoverImageView.image = nil
    }
}
