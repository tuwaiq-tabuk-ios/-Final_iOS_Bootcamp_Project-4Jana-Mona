//
//  ViewController.swift
//  4JANA-Project-Mona
//
//  Created by mona M on 18/05/1443 AH.
//

import UIKit
import Firebase

class SignInViewController: UIViewController  {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBOutlet weak var Email: UITextField!
  
  @IBOutlet weak var password: UITextField!
  
  @IBOutlet weak var login: UIButton!
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
    
  }
  
  
  @IBAction func btnLogIn(_ sender: UIButton) {
    
//    guard self.validation() else {
//      return
//    }
//
//    FirebaseManager.shared.login(Email:self.Email.text ?? "",
//                                          password:self.password.text ?? "")
//
//  }
//
   
  
  }
  
  
}
