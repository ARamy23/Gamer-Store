//
//  UserDefaultsManager.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

final class UserDefaultsManager: CacheProtocol {
    func getObject<T>(_ object: T.Type, key: String) -> T? where T : Decodable, T : Encodable {
        if object is String.Type {
            return getString(key: key) as? T
        } else {
            return getData(key: key)?[0].decode(object)
        }
    }
    
    func saveObject<T>(_ object: T, key: String) where T : Decodable, T : Encodable {
        if object is String {
            saveString(object as! String, key: key)
        } else {
            saveData(object.encode(), key: key)
        }
    }
    
    private func getString(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    func getData(key: String) -> [Data]? {
        return UserDefaults.standard.data(forKey: key).map({[$0]})
    }
    
    private func saveString(_ object: String, key: String) {
        UserDefaults.standard.set(object, forKey: key)
    }
    
    func saveData(_ data: Data, key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func removeObject(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
