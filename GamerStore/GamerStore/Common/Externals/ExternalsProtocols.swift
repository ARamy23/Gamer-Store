//
//  ExternalsProtocols.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UIViewController

enum CachingKey {
    case favorites
    case gamesFeed
    case seenGame(_ id: String)
    
    var key: String {
        switch self {
        case .favorites: return "favorites"
        case .gamesFeed: return "gamesFeed"
        case .seenGame(let id): return "seenGame-\(id)"
        }
    }
}

typealias AlertAction = (title: String, style: UIAlertAction.Style, action: () -> Void)

protocol CacheProtocol {
    func getData(key: String) -> [Data]?
    func saveData(_ data: Data, key: String)
    func getObject<T: Codable>(_ object: T.Type, key: String) -> T?
    func saveObject<T: Codable>(_ object: T, key: String)
    func removeObject(key: String)
}

protocol RouterProtocol: class {
    var presentedView: UIViewController! { set get }
    func present(view: UIViewController)
    func startActivityIndicator()
    func stopActivityIndicator()
    func dismiss()
    func pop()
    func popToRoot()
    func popTo(vc: UIViewController)
    func push(view: UIViewController)
    func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)])
    func alertWithAction(title: String?, message: String?, alertStyle: UIAlertController.Style, actions: [AlertAction])
}

protocol NetworkProtocol: class {
    func call<T: Codable>(_ endpoint: Endpoint, _ expectedModel: T.Type, onComplete: @escaping ((Result<T, Error>) -> Void))
    func cancelPreviousTask()
}

protocol SystemProtocol {
    func canOpenURLExternally(url: String) -> Bool
    func openURLExternally(url: String)
}
