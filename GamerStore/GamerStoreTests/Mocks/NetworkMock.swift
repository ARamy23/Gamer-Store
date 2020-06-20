//
//  NetworkMock.swift
//  GamerStoreTests
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation
@testable import GamerStore

class NetworkMock: NetworkProtocol {
    
    var didCancelARequest: Bool = false
    var calledAPIs = [Endpoint]()
    var expectedObject: Codable?
    var expectedObjects: [Codable]?
    var expectedError: Error?
    
    
    func call<T>(_ endpoint: Endpoint, _ expectedModel: T.Type, onComplete: @escaping ((Result<T, Error>) -> Void)) where T : Decodable, T : Encodable {
        calledAPIs.append(endpoint)
        if expectedObjects?.isEmpty == false, let object = self.expectedObjects?.removeFirst() as? T {
            onComplete(.success(object))
        } else if let object = self.expectedObject as? T {
            onComplete(.success(object))
        } else {
            onComplete(.failure(self.expectedError ?? NetworkError.somethingWentWrong))
        }
    }
    
    func cancelPreviousTask() {
        didCancelARequest = true
    }
    
    
}
