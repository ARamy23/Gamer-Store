//
//  RouterMock.swift
//  GamerStoreTests
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation
import UIKit

@testable import GamerStore

enum RoutingAction: Equatable {
    case present(_ vc: UIViewController.Type)
    case push(_ vc: UIViewController.Type)
    case activityStart
    case activityStop
    case dismiss
    case pop
    case popToRoot
    case popToVC
    case popTo(_ vc: UIViewController.Type)
    case alert(_ message: String)
    case gaveAnAlert
    case alertWithAction((title: String, message: String))
    
    static public func ==(lhs: RoutingAction, rhs: RoutingAction) -> Bool {
        switch (lhs, rhs) {
        case let (.popTo(a), .popTo(b)): return a == b
        case let (.present(a), .present(b)): return a == b
        case let (.push(a), .push(b)): return a == b
        case let (.alert(a), .alert(b)): return a == b
        case let (.alertWithAction(a), .alertWithAction(b)):
            return a.title == b.title && a.message == b.message
        case (.activityStart, .activityStart),
             (.activityStop, .activityStop),
             (.dismiss, .dismiss),
             (.pop, .pop),
             (.gaveAnAlert, .gaveAnAlert),
             (.popToRoot, .popToRoot),
             (.popToVC, .popToVC):
            return true
        default:
            return false
        }
    }
}

class RouterMock: RouterProtocol {
    
    weak var presentedView: UIViewController!
    
    var actions: [RoutingAction] = []
    
    var alertActions: [AlertAction] = []
    
    func popToRoot() {
        actions.append(.popToRoot)
    }
    
    func popTo(vc: UIViewController) {
        actions.append(.popToVC)
    }
    
    func push(view: UIViewController) {
        actions.append(.push(type(of: view)))
    }
    
    func present(view: UIViewController) {
        actions.append(.present(type(of: view)))
    }
    
    func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)]) {
        self.actions.append(.gaveAnAlert)
        self.actions.append(.alert(message))
    }
    
    func startActivityIndicator() {
        self.actions.append(.activityStart)
    }
    
    func stopActivityIndicator() {
        self.actions.append(.activityStop)
    }
    
    func dismiss() {
        self.actions.append(.dismiss)
    }
    
    func pop() {
        self.actions.append(.pop)
    }
    
    func alertWithAction(title: String?, message: String?, alertStyle: UIAlertController.Style, actions: [AlertAction]) {
        self.actions.append(.gaveAnAlert)
        self.actions.append(.alertWithAction((title ?? "", message ?? "")))
        self.alertActions.append(contentsOf: actions)
    }
    
    func alertWithActionLeftAlignment(title: String?, message: String?, alertStyle: UIAlertController.Style, actions: [AlertAction]) {
        self.actions.append(.gaveAnAlert)
        self.actions.append(.alertWithAction((title ?? "", message ?? "")))
        self.alertActions.append(contentsOf: actions)
    }
}
