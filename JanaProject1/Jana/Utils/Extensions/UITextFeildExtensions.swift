//
//  UITextFeildExtensions.swift
//  Created by mona M on 18/12/2021.


import Foundation
import UIKit

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor {
        set {
            self.attributedPlaceholder = NSAttributedString.init(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: newValue])
        }
        get {
            return .white
        }
    }
    
    var isValidValue: Bool {
        return self.text?.count != 0 && self.text != nil && !(self.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? false) != false
    }
    
}
