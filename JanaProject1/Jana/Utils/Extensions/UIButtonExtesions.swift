//
//  UIButtonExtesions.swift
//  Created by mona M on 18/12/2021.
//
//

import Foundation
import UIKit

extension UIButton {
  @IBInspectable var imageTinitColor: UIColor {
    set {
      let img = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
      self.setImage(img, for: .normal)
      self.tintColor = newValue
    } get {
      return self.tintColor
    }
  }
}
