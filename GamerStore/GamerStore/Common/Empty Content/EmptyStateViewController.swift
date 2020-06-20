//
//  EmptyStateViewController.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

class EmptyStateViewController: UIViewController {
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.3725490196, green: 0.3725490196, blue: 0.3725490196, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    var type: EmptyType = .favorites
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(subtitleLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        subtitleLabel.centerTo(view: self.view)
    }
    
    enum EmptyType {
        case search
        case home
        case favorites
    }
    
    init(_ type: EmptyType) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
        switch type {
        case .search:
            subtitleLabel.text = AppMessages.GamesFeed.couldntFindQuery.rawValue
        case .home:
            subtitleLabel.text = AppMessages.GamesFeed.couldntFetchGamesFeed.rawValue
        case .favorites:
            subtitleLabel.text = AppMessages.Favorites.noFavoritesFound.rawValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
