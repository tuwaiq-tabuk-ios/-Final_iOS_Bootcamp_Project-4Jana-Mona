//
//  SVC.swift
//  Jana
//
//  Created by mona M on 30/05/1443 AH.
//

import Foundation
import UIKit

class SignInViewController1: UIViewController {
  
  
  @IBOutlet weak var txtEmail: UITextField!
  
  @IBOutlet weak var txtPassword: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  
  }
  
  
  @IBAction func btnLogin(_ sender: UIButton) {
    
    guard self.validation() else {
        return
    }
//
//    FirebaseManager.shared.loginWithEmail(email: self.txtEmail.text ?? "", password: self.txtPassword.text ?? "")
//
    
}
  
  @IBAction func btnForgotPassword(_ sender: UIButton) {
    let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController")
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  
  @IBAction func btnSignUp(_ sender: UIButton) {
    let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "SignUpViewController")
    self.navigationController?.setViewControllers([vc], animated: true)
  }

  }
  
extension SignInViewController1 {
    
    func validation() -> Bool {
        
        guard let email = txtEmail.text, email.trimmingCharacters(in: .whitespaces) != "" else {
            self.showSnackbarMessage(message: "Please enter your email", isError: true)
            return false
        }
        
        guard let password = txtPassword.text, password.trimmingCharacters(in: .whitespaces) != "" else {
            self.showSnackbarMessage(message: "Please enter your password", isError: true)
            return false
        }
        
        guard email.isValidEmail() else {
            self.showSnackbarMessage(message: "Please enter a valid email", isError: true)
            return false
        }
        
        guard password.count > 5 else {
            self.showSnackbarMessage(message: "Password must be at least 6 characters long", isError: true)
            return false
        }
        
        return true
    }
    
}
  
  
  


