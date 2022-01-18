//
//  ChildrenTableViewCell.swift
//  Jana
//
//  Created by mona M on 1/1/2022.
//

import UIKit

class ChildrenTableViewCell: UITableViewCell {
  
  @IBOutlet weak var imgUser: UIImageView!
  
  @IBOutlet weak var lblChildName: UILabel!
  
  @IBOutlet weak var lblDateOfBirth: UILabel!
  
  var object: ChildModel?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  
  func configureCell() {
    if let obj = object {
     //??
      self.imgUser.imageURL(url: obj.iamge)
      self.lblChildName.text = obj.name
      self.lblDateOfBirth.text = obj.dateOfBirth
    }
  }
  
  
  @IBAction func btnDelete(_ sender: Any) {
    //??
    FirebaseManager.shared.deleteChild(uidChild: object?.uid ?? "")
  }
  
}
