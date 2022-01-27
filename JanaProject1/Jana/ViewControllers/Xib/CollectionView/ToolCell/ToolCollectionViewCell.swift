//
//  ToolCollectionViewCell.swift
//  Jana
//
//  Created by mona M on 18/12/2021.
//

import UIKit

class ToolCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imgItem: UIImageView!
  
  @IBOutlet weak var lblTitle: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  var object: Tool?
 
  
  func configureCell() {
    
    if let obj = object {
   
      self.imgItem.imageURL(url: obj.iamge ?? "")
      self.lblTitle.text = obj.title
    }
    
  }
  
}
