//
//  FirebaseManager.swift
//  Jana
//
//  Created by mona M on 21/12/2021.
//

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
    
    UtilsSV.showLoader(isShowLoader: true)
    
    Auth.auth().createUser(withEmail: email,
                           password: password) { (result, error) in
      //          Auth.auth().currentUser(
      if (error != nil) {
        AppDelegate.shared.rootNavigationViewController
          .showSnackbarMessage(message: error?.localizedDescription ?? "",
                               isError: true)
        
      } else {
        let udid = result?.user.uid ?? ""
        let dic: [String: Any] = ["udid": udid,
                                  "user-name": userName,
                                  "email": email,
        ]
        self.DB_REF.child("User").child(udid).setValue(dic)
      }
      
      if let _ = result {
        
        
        let vc = UIStoryboard.mainStoryboard
          .instantiateViewController(withIdentifier: "SignInViewController")
        AppDelegate.shared.rootNavigationViewController
          .setViewControllers([vc], animated: true)
      }
      
    }
    UtilsSV.showLoader(isShowLoader: false)
  }
  
  
  func loginWithEmail(email: String,
                      password: String) {
    
    UtilsSV.showLoader(isShowLoader: true)
    
    Auth.auth().signIn(withEmail: email,
                       password: password) { (result, error) in
      if error != nil {
        UtilsSV.showLoader(isShowLoader: false)
        AppDelegate.shared.rootNavigationViewController
          .showSnackbarMessage(message: "Please confirm your email or password",
                               isError: true)
        
      } else if let _ = Auth.auth().currentUser {
        UtilsSV.showLoader(isShowLoader: false)
        
        self.getUserByUdid(udid: result?.user.uid ?? "") { (user) in
          if let tempUser = user {
            UserProfile.shared.currentUser = tempUser
            
            
            let vc = UIStoryboard.mainStoryboard
              .instantiateViewController(withIdentifier: "MainTabbar")
            AppDelegate.shared.rootNavigationViewController
              .setViewControllers([vc], animated: true)
          }
          
        }
        
      }
    }
  }
  
  
  func forgotPassword(email: String) {
    UtilsSV.showLoader(isShowLoader: true)
    
    Auth.auth().sendPasswordReset(withEmail: email) { error in
      UtilsSV.showLoader(isShowLoader: false)
      if error != nil {
        AppDelegate.shared.rootNavigationViewController
          .showSnackbarMessage(message:error?.localizedDescription ?? "",
                               isError: true)
      
        
      } else {
        AppDelegate.shared.rootNavigationViewController
          .showSnackbarMessage(message: "A password reset link has been sent to your email",
                               isError: false)
        AppDelegate.shared.rootNavigationViewController.popViewController(animated: true)
      }
    }
  }
  
  
  func logout(completion: @escaping (_ success: Bool) -> Void) {
    UtilsSV.showLoader(isShowLoader: true)
    
    do {
      try Auth.auth().signOut()
      UserProfile.shared.currentUser = nil
      UtilsSV.showLoader(isShowLoader: false)
      
      let vc = UIStoryboard.mainStoryboard
        .instantiateViewController(withIdentifier: "SignInViewController")
      AppDelegate.shared.rootNavigationViewController
        .setViewControllers([vc], animated: true)
      completion(true)
      
    } catch {
      UtilsSV.showLoader(isShowLoader: false)
      completion(false)
    }
  }
  
  
  func getAllUsers(completion: @escaping (_ date: [User]) -> Void) {
    
    UtilsSV.showLoader(isShowLoader: true)
    
    self.DB_REF.child("User")
        .observe(.value) { (DataSnapshot) in
      if let value = DataSnapshot.value as? [String : AnyObject] {
        var data: [User] = []
        do {
          for (_, item) in value {
            let model = try FirebaseDecoder().decode(User.self, from: item)
            data.append(model)
          }
        } catch {
          
        }
        
        completion(data)
      }
    }
    
    UtilsSV.showLoader(isShowLoader: false)
  }
  
  
  func getUserByUdid(udid: String,
                     completion: @escaping (_ user: User?) -> Void) {
    
    UtilsSV.showLoader(isShowLoader: true)
    
    self.DB_REF.child("User").child(udid).observe(.value) { (snapshot) in
      if let value = snapshot.value as? [String : AnyObject] {
        
        do {
          let model = try FirebaseDecoder().decode(User.self, from: value)
          completion(model)
        }
        catch {
          AppDelegate.shared.rootNavigationViewController
            .showSnackbarMessage(message: "There was a problem logging in", isError: true)
          completion(nil)
        }
        completion(nil)
      }
    }
    UtilsSV.showLoader(isShowLoader: false)
  }
  
  
  func addArticle(title: String,
                  details: String) {
    
    UtilsSV.showLoader(isShowLoader: true)
    
    let udid = self.DB_REF.childByAutoId().key ?? ""
    let dictionary: [String: Any] = [
      "udid": udid,
      "title": title,
      "details": details,
      "created-date": Date()
        .toString(customFormat: "E, d MMM yyyy HH:mm:ss Z"),
    ]
    self.DB_REF.child("Article").child(udid).setValue(dictionary)
    
    UtilsSV.showLoader(isShowLoader: false)
    
  }
  
  
  func getArticles(completion: @escaping (_ date: [Article]) -> Void) {
    
    UtilsSV.showLoader(isShowLoader: true)
    
    self.DB_REF.child("Article")
      .observe(.value) { (snapshot) in
      
      if let value = snapshot.value as? [String : AnyObject] {
        var data: [Article] = []
        
        do {
          for (_, item) in value {
            let model = try FirebaseDecoder()
              .decode(Article.self, from: item)
            data.append(model)
          }
        }
        catch {
          
        }
        
        let tempData = data.sorted(by: { $0.createdDate.toDate(customFormat: "yyyy HH:mm:ss").compare($1.createdDate.toDate(customFormat: "yyyy HH:mm:ss")) == .orderedAscending })
        
        completion(tempData)
      }
    }
    UtilsSV.showLoader(isShowLoader: false)
  }
  
  
  func addMessage(uidUser: String,
                  message: String) {
    
    let uid = self.DB_REF.childByAutoId().key ?? ""
    let dictionary: [String: Any] = ["uid": uid,
                              "uid-user": uidUser,
                              "message": message,
                              "is-read": false,
                              "uid-sender": Auth.auth().currentUser?.uid ?? "",
                              "created-date": Date().toString(customFormat: "E, d MMM yyyy HH:mm:ss Z"),
    ]
    self.DB_REF.child("Messages").child(uid).setValue(dictionary)
    
  }
  
  
  func getMessages(completion: @escaping (_ data: [Message]) -> Void) {
    
    self.DB_REF.child("Messages").observe(.value) { (snapshot) in
      if let value = snapshot.value as? [String : AnyObject] {
        var data: [Message] = []
        
        do {
          for (_, value) in value {
            let model = try FirebaseDecoder().decode(Message.self,
                                                     from: value)
            data.append(model)
          }
        }
        catch let error {
          print(error)
        }
        
        let tempData = data.sorted(by: { $0.createdDate.toDate(customFormat: "E, d MMM yyyy HH:mm:ss Z").compare($1.createdDate.toDate(customFormat: "E, d MMM yyyy HH:mm:ss Z")) == .orderedAscending })
        
        completion(tempData)
      }
    }
    
  }
  
  
  func addChild(image: UIImage?,
                name: String,
                dateOfBirth: String,
                relationship: String) {
    
    UtilsSV.showLoader(isShowLoader: true)
    
    FirebaseManager.shared.uploadImage(image: image) { url, isError in
      
      UtilsSV.showLoader(isShowLoader: false)
      
      if isError ?? false {
        return
      }
      
      let uid = self.DB_REF.childByAutoId().key ?? ""
      let dictionary: [String: Any] = ["uid": uid,
                                "iamge": url,
                                "name": name,
                                "date-of-birth": dateOfBirth,
                                "relationship": relationship,
                                "created-date": Date().toString(customFormat: "E, d MMM yyyy HH:mm:ss Z"),
      ]
      self.DB_REF.child("Children").child(UserProfile.shared.currentUser?.udid ?? "").child(uid).setValue(dictionary)
      
      AppDelegate.shared.rootNavigationViewController.popViewController(animated: true)
      
    }
  }
  
  
  func getChildren(completion: @escaping (_ data: [Child]) -> Void) {
    
    self.DB_REF.child("Children").child(UserProfile.shared.currentUser?.udid ?? "").observe(.value) { (snapshot) in
      if let value = snapshot.value as? [String : AnyObject] {
        var data: [Child] = []
        
        do {
          for (_, value) in value {
            let model = try FirebaseDecoder().decode(Child.self, from: value)
            data.append(model)
          }
        }
        catch let error {
          print(error)
        }
        
        let tempData = data.sorted(by: { $0.createdDate.toDate(customFormat: "E, d MMM yyyy HH:mm:ss Z").compare($1.createdDate.toDate(customFormat: "E, d MMM yyyy HH:mm:ss Z")) == .orderedAscending })
        completion(tempData)
      }
    }
    
  }
  
  
  func addTool(image: UIImage?,
               type: K.Sections) {
    
    UtilsSV.showLoader(isShowLoader: true)
    
    FirebaseManager.shared.uploadImage(image: image) { url, isError in
      
      UtilsSV.showLoader(isShowLoader: false)
      
      if isError ?? false {
        return
      }
      
      let uid = self.DB_REF.childByAutoId().key ?? ""
      let dictionary: [String: Any] = ["uid": uid,
                                "iamge": url,
                                "title": "",
                                "type": type.rawValue,
                                "created-date": Date().toString(customFormat: "E, d MMM yyyy HH:mm:ss Z"),
      ]
      self.DB_REF.child("Tools").child(UserProfile.shared.currentUser?.udid ?? "").child(uid).setValue(dictionary)
      
    }
  }
  
  
  func getMyTools(completion: @escaping (_ data: [Tool]) -> Void) {
    
    self.DB_REF.child("Tools").child(UserProfile.shared.currentUser?.udid ?? "").observe(.value) { (Datasnapshot) in
      if let value = Datasnapshot.value as? [String : AnyObject] {
        var data: [Tool] = []
        
        do {
          for (_, value) in value {
            let model = try FirebaseDecoder().decode(Tool.self,
                                                     from: value)
            data.append(model)
          }
        }
        catch let error {
          print(error)
        }
        
        let tempData = data.sorted(by: { $0.createdDate?.toDate(customFormat: "E, d MMM yyyy HH:mm:ss Z").compare($1.createdDate?.toDate(customFormat: "E, d MMM yyyy HH:mm:ss Z") ?? Date()) == .orderedAscending })
        completion(tempData)
      }
      else {
        completion([])
      }
    }
    
  }
  
  
  func deleteChild(uidChild: String) {
    self.DB_REF.child("Children").child(UserProfile.shared.currentUser?.udid ?? "").child(uidChild).setValue(nil)
  }
  
  private func uploadImage(image: UIImage?,
                           completion: @escaping (_ url: String, _ isError: Bool?) -> Void) {
    
    let udid = self.DB_REF.childByAutoId().key ?? ""
    
    let storage = Storage.storage()
    
    let storageRef = storage.reference().child("images/\(udid).png")
    
    guard let _image = image else {
      completion("", true)
      return
    }
    
    guard let uploadData = _image.jpegData(compressionQuality: 0.5) else {
      completion("", true)
      return
    }
    
    guard image != nil else {
      completion("", true)
      return
    }
    
    storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
      // You can also access to download URL after upload.
      
      if ((error) != nil) {
        completion("", true)
        return
      }
      
      storageRef.downloadURL { (url, error) in
        guard url != nil else {
          completion("", true)
          return
        }
        completion(url?.absoluteString ?? "", false)
      }
      
    }
    
  }
  
}
