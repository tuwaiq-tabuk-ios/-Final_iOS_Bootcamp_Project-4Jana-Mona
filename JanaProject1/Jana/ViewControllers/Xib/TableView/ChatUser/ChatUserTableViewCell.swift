//
//  ChatUserTableViewCell.swift
//  Jana
//
//  Created by mona M  on 18/12/2021.
//

import UIKit

class ChatUserTableViewCell: UITableViewCell {
  
  @IBOutlet weak var imgUser: UIImageView!
  
  @IBOutlet weak var lblUserName: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  var object: UserModel?
  
  func configureCell() {
    if let obj = object {
      self.lblUserName.text = obj.userName
    }
  }
  
}
