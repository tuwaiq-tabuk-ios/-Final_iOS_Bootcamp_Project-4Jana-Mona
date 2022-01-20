//
//  MenuTableViewCell.swift
//  Jana
//
//  Created by mona M on 21/12/2021.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
  
  @IBOutlet weak var lblTitle: UILabel!
  
  @IBOutlet weak var icArrow: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  var object: Constants.Menu?
     
  func configureCell() {
    if let obj = object {
      self.lblTitle.text = obj.title
  
      self.icArrow.isHidden = obj == .logout
    }
  }
  
}

