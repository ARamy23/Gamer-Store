//
//  Endpoint.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

// We are encapsulating the logic of our APIs behind a protocol called Endpoint
// this endpoint can be anything
// it can be our own Endpoint enum that follows the same concept of Moya's TargetType
// and we can also use it with any Networking Pod like Alamofire or Moya through
// an adapter pattern if needed

/// A protocol that carries the request details for the network manager to use
protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    var encoding: ParametersEncoding { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    /// Base URL for calling endpoints which is configurable according to Build
    /// Configurations
    var baseURL: String {
        #if DEBUG
        return "https://api.rawg.io/api/"
        #elseif RELEASE
        return "https://api.rawg.io/api/"
        #elseif STAGING
        return "https://api.rawg.io/api/"
        #endif
    }
    
    var headers: [String: String] {
        return [:]
    }
}

/// Determines how the network manager will encode the parameters when firing the
/// request
enum ParametersEncoding {
    /// Encodes the parameters as url query parameters
    case urlEncoding
    /// Encodes the aprameters in the body of the request
    case jsonEncoding
}

enum HTTPMethod: String {
    case GET
}
