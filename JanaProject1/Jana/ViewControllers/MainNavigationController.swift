//
//  MainNavigationController.swift
//  Jana
//
//  Created by mona M on 18/12/2021.
//

import UIKit

class MainNavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  

  func setupView() {
    AppDelegate.shared.rootNavigationViewController = self
    
    var vcName = "SignInViewController"
    
    if let _ =  UserProfile.shared.currentUser {
      vcName = "MainTabbar"
    }
    
    let vc = UIStoryboard.mainStoryboard
      .instantiateViewController(withIdentifier: vcName)
    AppDelegate.shared.rootNavigationViewController
      .setViewControllers([vc], animated: true)
  }
}
