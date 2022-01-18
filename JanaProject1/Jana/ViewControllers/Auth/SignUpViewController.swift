//
//  SignUpViewController.swift
//  Jana
//
//  Created by mona M  on 18/12/2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtUserName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
  @IBOutlet weak var btnSignUp: UIButton!
  @IBOutlet weak var btnLogin: UIButton!
  
  @IBOutlet weak var addYourDetailsToIogIn: UILabel!
  @IBOutlet weak var SignUp: UILabel!
  
  @IBOutlet weak var haveAnAccount: UILabel!
  
  override func viewDidLoad() {
        super.viewDidLoad()
      localization ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
      txtEmail.resignFirstResponder()
    txtPassword.resignFirstResponder()
  }
  
  
    @IBAction func btnSignUp(_ sender: Any) {
        
        guard self.validation() else {
            return
        }
        
        FirebaseManager.shared.createAccount(userName: self.txtUserName.text ?? "",
                                             email: self.txtEmail.text ?? "",
                                             password: self.txtPassword.text ?? "")
        
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
}

extension SignUpViewController {
  
  func localization () {
    SignUp.text = NSLocalizedString("Sign Up", comment: "")
    haveAnAccount.text = NSLocalizedString("Have An Account", comment: "")
    
    addYourDetailsToIogIn.text = NSLocalizedString("Add your details to login", comment: "")
    
    btnLogin.setTitle (NSLocalizedString("Login", comment: ""),for:.normal)
    btnSignUp.setTitle (NSLocalizedString("Sign Up", comment: ""),for:.normal)
    

  }

}


extension SignUpViewController {
    
    func validation() -> Bool {
        
        guard let userName = txtUserName.text, userName.trimmingCharacters(in: .whitespaces) != "" else {
            self.showSnackbarMessage(message: "Please enter your username", isError: true)
            return false
        }
        
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
