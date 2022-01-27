//
//  File.swift
//  Jana
//
//  Created by mona M on 22/06/1443 AH.
//

import Foundation
import SVProgressHUD


struct UtilsSV {
  static func showLoader(isShowLoader: Bool) {
    if isShowLoader {
      SVProgressHUD.setDefaultMaskType(.custom)
      SVProgressHUD.setForegroundColor("PrimaryColor".color_)
      SVProgressHUD.setBackgroundColor(UIColor.white)
      SVProgressHUD.show()
    } else {
      SVProgressHUD.dismiss()
    }
  }

  
  
  
  
  
  
}

