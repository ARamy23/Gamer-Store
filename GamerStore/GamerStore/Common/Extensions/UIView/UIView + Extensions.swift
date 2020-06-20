//
//  UIView + Extensions.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UIView

extension UIView {
    
    /// Adds the ability to configure the corner radius from the IB
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    /// Adds an acitivity indicator to the center of the parent view and gives it a tag of 475647 to later dismiss it
    /// - Parameters:
    ///   - activityColor: the color of the activity
    ///   - backgroundColor: the background color of the activity
    func activityStartAnimating(activityColor: UIColor = GSColor.white.color, backgroundColor: UIColor = GSColor.black.color.withAlphaComponent(0.75)) {
        guard self.viewWithTag(475647) == nil else { return }
        let backgroundView = UIView()
        backgroundView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        backgroundView.center = self.center
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        backgroundView.cornerRadius = 16
        
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        activityIndicator.center = backgroundView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = activityColor
        activityIndicator.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        activityIndicator.startAnimating()
        
        backgroundView.addSubview(activityIndicator)
        self.addSubview(backgroundView)
        activityIndicator.centerTo(view: backgroundView)
    }
    
    /// Dismiss the activity indicator view with the tag 475647 in the current view hierarchy
    func activityStopAnimating() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
    }
    
    /// Centers the current view to the passed view
    /// - Parameter view: the view that the current view will be centered to
    func centerTo(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
