//
//  NetworkError.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case somethingWentWrong
}

extension NetworkError {
    var localizedDescription: String {
        switch self {
        case .somethingWentWrong:
            return "Something went wrong, please try again later"
        }
    }
}

extension Error {
    func shouldIgnore() -> Bool {
        switch self.localizedDescription {
        case "cancelled":
            return true
        default:
            return false
        }
    }
}
