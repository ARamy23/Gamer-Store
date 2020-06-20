//
//  Colors.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UIColor

enum GSColor {
    case black
    case white
    case reddishOrange
    case gray
    case selectedGray
    
    var color: UIColor {
        switch self {
        case .black:
            return UIColor(named: "Black") ?? .red
        case .white:
            return UIColor(named: "White") ?? .red
        case .reddishOrange:
            return UIColor(named: "Reddish Orange") ?? .red
        case .gray:
            return UIColor(named: "Gray") ?? .red
        case .selectedGray:
            return UIColor(named: "Selected Gray") ?? .red
        }
    }
}
