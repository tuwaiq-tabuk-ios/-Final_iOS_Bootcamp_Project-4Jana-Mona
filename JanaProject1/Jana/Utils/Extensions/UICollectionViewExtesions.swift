//
//  UICollectionViewExtesions.swift
//  Created by mona M on 18/12/2021.


import Foundation
import UIKit

extension UICollectionView {
  
  func registerCell(nibName: String) {
    self.register(UINib(nibName: nibName,
                        bundle: nil),
                  forCellWithReuseIdentifier: nibName)
  }
  
}
