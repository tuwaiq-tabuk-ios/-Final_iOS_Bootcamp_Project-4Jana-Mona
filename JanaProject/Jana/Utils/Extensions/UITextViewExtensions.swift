//
//  UITextViewExtensions.swift
//  Created by mona M on 18/12/2021.


import Foundation
import UIKit

extension UITextView {
    var isValidValue: Bool {
        return self.text?.count != 0 && self.text != nil
    }
}

