
import UIKit

class ForgotPasswordViewController: UIViewController {
  
  @IBOutlet weak var txtEmail: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
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
  
  func validation() -> Bool {
    
    guard let email = txtEmail.text, email.trimmingCharacters(in: .whitespaces) != "" else {
      self.showSnackbarMessage(message: "Please enter your email", isError: true)
      return false
    }
    
    guard email.isValidEmail() else {
      self.showSnackbarMessage(message: "Please enter a valid email", isError: true)
      return false
    }
    
    return true
  }
  
}
