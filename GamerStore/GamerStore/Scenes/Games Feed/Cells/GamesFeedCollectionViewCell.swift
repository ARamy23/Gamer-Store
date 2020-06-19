//
//  GamesFeedCollectionViewCell.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

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
        ImagesManager.shared.getImage(from: viewModel.imageURL, completionHandler: { [weak self] (image) in
            guard let self = self else { return }
            self.gameCoverImageView.image = image
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameCoverImageView.image = nil
    }
}
