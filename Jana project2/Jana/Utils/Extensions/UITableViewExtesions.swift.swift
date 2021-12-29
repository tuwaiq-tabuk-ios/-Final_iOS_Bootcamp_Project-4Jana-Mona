

import Foundation
import UIKit

extension UITableView {
  
  func registerCell(nibName: String) {
    self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
  }
  
}
