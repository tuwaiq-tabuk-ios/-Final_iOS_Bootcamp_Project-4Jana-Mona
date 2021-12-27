

import Foundation
import UIKit

extension UICollectionView {
    
    func registerCell(nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
}
