//
//  CacheMock.swift
//  GamerStoreTests
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

@testable import GamerStore

class CacheMock: CacheProtocol {
    var dataStorage: [String: Any] = [:] {
        didSet {
            didCacheSomething = true
        }
    }
    
    var didCacheSomething: Bool = false
    var didFetchFromCache: Bool = false
    var didRemoveSomethingFromCache: Bool = false
    
    func saveData(_ data: Data, key: String) {
        dataStorage[key] = data
    }
    
    func getObject<T>(_ object: T.Type, key: String) -> T? where T : Decodable, T : Encodable {
        let fetchedObject = dataStorage[key] as? T
        didFetchFromCache = fetchedObject != nil
        return fetchedObject
    }
    
    func getData(key: String) -> [Data]? {
        let fetchedObject = (dataStorage[key] as? Data).map({[$0]})
        didFetchFromCache = fetchedObject != nil
        return fetchedObject
    }
    
    func saveData(_ data: Data?, key: String) {
        dataStorage[key] = data
    }
    
    func saveObject<T>(_ object: T, key: String) {
        dataStorage[key] = object
    }
    
    func removeObject(key: String) {
        dataStorage.removeValue(forKey: key)
        didRemoveSomethingFromCache = true
    }
}
