

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    @IBInspectable var imageColor: UIColor {
        set {
            let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
            self.image = templateImage
            self.tintColor = newValue
        } get {
            return self.tintColor
        }
    }
    
    func imageURL(url: String) {
        self.sd_setImage(with: URL(string: url), placeholderImage: nil)
    }
    
}
