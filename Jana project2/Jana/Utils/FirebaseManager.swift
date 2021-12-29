

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import CodableFirebase
import SVProgressHUD

class FirebaseManager {
  
  static let shared = FirebaseManager()
  
  let DB_REF = Database.database().reference()
  
  func createAccount(userName: String,
                     email: String,
                     password: String) {
    
    FirebaseManager.showLoader(isShowLoader: true)
    
    Auth.auth().createUser(withEmail: email,
                           password: password) { (result, error) in
      
      if (error != nil) {
        AppDelegate.shared.rootNavigationViewController.showSnackbarMessage(message: error?.localizedDescription ?? "", isError: true)
      } else {
        let udid = result?.user.uid ?? ""
        let dic: [String: Any] = ["udid": udid,
                                  "user-name": userName,
                                  "email": email,
        ]
        self.DB_REF.child("User").child(udid).setValue(dic)
      }
      
      if let _ = result {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "SignInViewController")
        AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
      }
      
    }
    
    FirebaseManager.showLoader(isShowLoader: false)
    
  }
  
  func loginWithEmail(email: String, password: String) {
    FirebaseManager.showLoader(isShowLoader: true)
    Auth.auth().signIn(withEmail: email,
                       password: password) { (result, error) in
      if error != nil {
        FirebaseManager.showLoader(isShowLoader: false)
        AppDelegate.shared.rootNavigationViewController.showSnackbarMessage(message: "Please confirm your email or password", isError: true)
      } else if let _ = Auth.auth().currentUser {
        FirebaseManager.showLoader(isShowLoader: false)
        
        self.getUserByUdid(udid: result?.user.uid ?? "") { (user) in
          
          if let tempUser = user {
            UserProfile.shared.currentUser = tempUser
            
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "MainTabbar")
            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
          }
          
        }
        
      }
    }
  }
  
  func forgotPassword(email: String) {
    FirebaseManager.showLoader(isShowLoader: true)
    Auth.auth().sendPasswordReset(withEmail: email) { error in
      FirebaseManager.showLoader(isShowLoader: false)
      if error != nil {
        AppDelegate.shared.rootNavigationViewController.showSnackbarMessage(message: error?.localizedDescription ?? "", isError: true)
      } else {
        AppDelegate.shared.rootNavigationViewController.showSnackbarMessage(message: "A password reset link has been sent to your email", isError: false)
        AppDelegate.shared.rootNavigationViewController.popViewController(animated: true)
      }
    }
  }
  
  func getUserByUdid(udid: String, completion: @escaping (_ user: UserModel?) -> Void) {
    
    FirebaseManager.showLoader(isShowLoader: true)
    
    self.DB_REF.child("User").child(udid).observe(.value) { (snapshot) in
      if let value = snapshot.value as? [String : AnyObject] {
        do {
          let model = try FirebaseDecoder().decode(UserModel.self, from: value)
          completion(model)
        } catch {
          AppDelegate.shared.rootNavigationViewController.showSnackbarMessage(message: "There was a problem logging in", isError: true)
          completion(nil)
        }
        completion(nil)
      }
    }
    FirebaseManager.showLoader(isShowLoader: false)
  }
  
  
  
  func addArticle(title: String, details: String) {
    
    FirebaseManager.showLoader(isShowLoader: true)
    
    let udid = self.DB_REF.childByAutoId().key ?? ""
    let dic: [String: Any] = [
      "udid": udid,
      "title": title,
      "details": details,
      "created-date": Date().toString(customFormat: "E, d MMM yyyy HH:mm:ss Z"),
    ]
    self.DB_REF.child("Article").child(udid).setValue(dic)
    
    FirebaseManager.showLoader(isShowLoader: false)
    
  }
  
  
  func getArticles(completion: @escaping (_ date: [ArticleModel]) -> Void) {
    
    FirebaseManager.showLoader(isShowLoader: true)
    
    self.DB_REF.child("Article").observe(.value) { (snapshot) in
      if let value = snapshot.value as? [String : AnyObject] {
        var data: [ArticleModel] = []
        do {
          for (_, item) in value {
            let model = try FirebaseDecoder().decode(ArticleModel.self, from: item)
            data.append(model)
          }
        } catch {
          
        }
        
        let tempData = data.sorted(by: { $0.createdDate.toDate(customFormat: "yyyy HH:mm:ss").compare($1.createdDate.toDate(customFormat: "yyyy HH:mm:ss")) == .orderedAscending })
        
        completion(tempData)
      }
    }
    FirebaseManager.showLoader(isShowLoader: false)
  }
  
  
  class func showLoader(isShowLoader: Bool) {
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
