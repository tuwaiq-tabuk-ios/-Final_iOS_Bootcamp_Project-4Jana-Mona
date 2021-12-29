

import Foundation
import UIKit

extension Date {
  
  //Convert date to String
  func toString(customFormat: String, timeZone: String = "UTC") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.init(identifier: "en")
    dateFormatter.calendar = Calendar.init(identifier: .gregorian)
    dateFormatter.timeZone = TimeZone.init(identifier: timeZone)
    dateFormatter.dateFormat = customFormat
    return dateFormatter.string(from: self)
  }
  
  var timeAgoDisplay: String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    return formatter.localizedString(for: self, relativeTo: Date())
  }
  
}
