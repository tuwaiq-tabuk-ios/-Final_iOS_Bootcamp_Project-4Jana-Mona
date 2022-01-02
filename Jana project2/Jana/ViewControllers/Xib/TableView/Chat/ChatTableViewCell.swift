
//
//  SceneDelegate.swift
//  Jana
//
//  Created by mona M on 26/05/1443 AH.
//
import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stContainer: UIStackView!
    
    @IBOutlet weak var vwLeft: UIView!
    
    @IBOutlet weak var stDate: UIStackView!
    
    @IBOutlet weak var vwMessage: UIView!
    
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var vwRight: UIView!
    
    enum MessageSender {
        case me
        case he
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var object: MessageModel?
    
    @IBAction func btnOnTapMessage(_ sender: Any) {
//        if self.lblDate.textColor == .clear {
//            self.lblDate.textColor = .darkGray
//        } else {
//            self.lblDate.textColor = .clear
//        }
    }
    
    func configureCell() {
        if let obj = object {
            self.lblMessage.text = obj.message
            self.lblDate.text = obj.createdDate
            self.setUpCell(sender: obj.uidSender == UserProfile.shared.currentUser?.udid ? .me : .he)
        }
    }
    
    func setUpCell(sender: MessageSender) {
        switch sender {
        case .me:
            self.vwLeft.isHidden = true
            self.stContainer.alignment = .leading
            self.stDate.alignment = .leading
            self.vwMessage.backgroundColor = "PrimaryColor".color_
            self.vwRight.isHidden = false
            break
        
        case .he:
            self.vwLeft.isHidden = false
            self.stContainer.alignment = .trailing
            self.stDate.alignment = .trailing
            self.vwMessage.backgroundColor = .lightGray
            self.vwRight.isHidden = true
            break
        }
    }
    

  }
  


