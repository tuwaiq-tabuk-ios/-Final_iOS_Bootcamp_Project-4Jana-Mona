//
//  ForgotPasswordViewController.swift
//  Jana
//
//  Created by mona M  on 18/12/2021.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
  
  @IBOutlet weak var ResetPassword: UILabel!
  @IBOutlet weak var EnterEmail: UILabel!
  
  @IBOutlet weak var btnSend: UIButton!
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      localization ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
  
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
      txtEmail.resignFirstResponder()
   
  }
  
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSend(_ sender: Any) {
        
        guard self.validation() else {
            return
        }
        
        FirebaseManager.shared.forgotPassword(email: self.txtEmail.text ?? "")
        
    }
    
}

extension ForgotPasswordViewController {
  
  func localization () {
    ResetPassword.text = NSLocalizedString("ResetPassword", comment: "")
    EnterEmail.text = NSLocalizedString("Please enter your email to receive a  link to  create a new password via email", comment: "")
    btnSend.setTitle (NSLocalizedString("Send", comment: ""),for:.normal)
   
  }
}



extension ForgotPasswordViewController {
    
    func validation() -> Bool {
        
        guard let email = txtEmail.text,
                  email.trimmingCharacters(in: .whitespaces) != "" else {
            self.showSnackbarMessage(message: "Please enter your email",
                                     isError: true)
            return false
        }
        
        guard email.isValidEmail() else {
            self.showSnackbarMessage(message: "Please enter a valid email",
                                     isError: true)
            return false
        }
        
        return true
    }
    
}
