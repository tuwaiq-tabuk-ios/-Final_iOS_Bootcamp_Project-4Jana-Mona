

import Foundation
import UIKit
extension String {
  func isValidEmail() -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: self)
  }
  
  var isURL: Bool {
    if let url = NSURL(string: self) {
      return UIApplication.shared.canOpenURL(url as URL)
    }
    return false
  }
  
  var image_: UIImage? {
    return UIImage.init(named: self)
  }
  
  var localize_: String {
    return NSLocalizedString(self, comment: "")
  }
  
  var color_: UIColor {
    return UIColor(named: self) ?? .black
  }
  
  
  func toDate(customFormat: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.init(identifier: "en")
    dateFormatter.calendar = Calendar.init(identifier: .gregorian)
    dateFormatter.timeZone = TimeZone.init(identifier: "UTC")
    dateFormatter.dateFormat = customFormat
    return dateFormatter.date(from: self) ?? Date()
  }
}
