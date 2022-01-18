//
//  HomeCellCollectionViewCell.swift
//  Jana
//
//  Created by mona M on 18/12/2021.

import UIKit

class HomeCellCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imgItem: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  var object: Constants.sections?
  
  
  func configureCell() {
    if let obj = object {
      //??
      self.imgItem.image = obj.image.image_
      
    }
  }
  
}
