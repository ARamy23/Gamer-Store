//
//  Router.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UIViewController

typealias AlertAction = (title: String, style: UIAlertAction.Style, action: () -> Void)

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

final class Router: RouterProtocol {
    weak var presentedView: UIViewController!
    
    func present(view: UIViewController) {
        presentedView?.present(view, animated: true, completion: nil)
    }
    
    func startActivityIndicator() {
        presentedView?.view.activityStartAnimating()
    }
    
    func stopActivityIndicator() {
        presentedView?.view.activityStopAnimating()
    }
    
    func dismiss() {
        presentedView?.dismiss(animated: true, completion: nil)
    }
    
    func pop() {
        _ = presentedView?.navigationController?.popViewController(animated: true)
    }
    
    func popToRoot() {
        _ = presentedView?.navigationController?.popToRootViewController(animated: true)
    }
    
    func popTo(vc: UIViewController) {
        _ = presentedView?.navigationController?.popToViewController(vc, animated: true)
    }
    
    func push(view: UIViewController) {
        presentedView?
            .navigationController?
            .pushViewController(view, animated: true)
    }
    
    func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.map {
                UIAlertAction(title: $0.title, style: $0.style, handler: nil)
        }.forEach {
            alert.addAction($0)
        }
        presentedView?.present(alert, animated: true)
    }
    
    func alertWithAction(title: String?,
                         message: String?,
                         alertStyle: UIAlertController.Style,
                         actions: [AlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        actions.map { action in
            UIAlertAction(title: action.title, style: action.style, handler: { (_) in
                action.action()
            })
        }.forEach {
            alert.addAction($0)
        }
        presentedView?.present(alert, animated: true)
    }
}
