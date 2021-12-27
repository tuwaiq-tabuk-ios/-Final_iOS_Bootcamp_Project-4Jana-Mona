
import Foundation
import UIKit

extension UITextView {
    var isValidValue: Bool {
        return self.text?.count != 0 && self.text != nil
    }
}

