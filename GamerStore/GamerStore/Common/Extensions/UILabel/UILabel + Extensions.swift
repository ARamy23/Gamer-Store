//
//  UILabel + Extensions.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UILabel
import Foundation

extension UILabel {
    
    @IBInspectable
    var lineHeightMultip: CGFloat {
        set{
            
            //get our existing style or make a new one
            let paragraphStyle: NSMutableParagraphStyle
            if let existingStyle = attributedText?.attribute(NSAttributedString.Key.paragraphStyle, at: 0, effectiveRange: .none) as? NSParagraphStyle, let mutableCopy = existingStyle.mutableCopy() as? NSMutableParagraphStyle  {
                paragraphStyle = mutableCopy
            } else {
                paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 1.0
                paragraphStyle.alignment = self.textAlignment
            }
            paragraphStyle.lineHeightMultiple = newValue
            
            //set our text from existing text
            let attrString = NSMutableAttributedString()
            if let text = self.text {
                attrString.append( NSMutableAttributedString(string: text))
                attrString.addAttribute(NSAttributedString.Key.font, value: self.font, range: NSMakeRange(0, attrString.length))
            }
            else if let attributedText = self.attributedText {
                attrString.append( attributedText)
            }
            
            //add our attributes and set the new text
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
            self.attributedText = attrString
        }
        
        get {
            if let paragraphStyle = attributedText?.attribute(NSAttributedString.Key.paragraphStyle, at: 0, effectiveRange: .none) as? NSParagraphStyle {
                return paragraphStyle.lineHeightMultiple
            }
            return 0
        }
    }
}
