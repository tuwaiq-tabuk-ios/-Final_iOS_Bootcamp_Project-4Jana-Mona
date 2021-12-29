

import Foundation

class UserProfile {
  
  static let shared = UserProfile()
  
  var currentUser: UserModel? {
    set {
      guard newValue != nil else {
        UserDefaults.standard.removeObject(forKey: "current-user")
        return
        
      }
      
      let encodedData = try? PropertyListEncoder().encode(newValue)
      UserDefaults.standard.set(encodedData, forKey: "current-user")
      UserDefaults.standard.synchronize()
    } get {
      if let data = UserDefaults.standard.value(forKey: "current-user") as? Data {
        return try? PropertyListDecoder().decode(UserModel.self, from: data)
      }
      
      return nil
      
    }
  }
  
}
