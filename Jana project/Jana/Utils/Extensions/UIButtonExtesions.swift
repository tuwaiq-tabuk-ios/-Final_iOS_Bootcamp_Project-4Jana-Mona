

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
