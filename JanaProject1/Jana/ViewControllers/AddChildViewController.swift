//
//  AddChildViewController.swift
//  Jana
//
//  Created by mona M on 01/06/1443 AH.
//

import UIKit

class AddChildViewController: UIViewController {
  
  @IBOutlet weak var imgUser: UIImageView!
  
  @IBOutlet weak var txtName: UITextField!
  
  @IBOutlet weak var txtDateOfBirth: UITextField!
  
  @IBOutlet weak var txtRelationship: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  @IBAction func btnBack(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func btnUploadImage(_ sender: Any) {
    
    let picker = ImagePicker.shared.picker
    
    picker.didFinishPicking { [unowned picker] items, _ in
      if let photo = items.singlePhoto {
        self.imgUser.image = photo.image
      }
      picker.dismiss(animated: true, completion: nil)
    }
    present(picker, animated: true, completion: nil)
    
  }
  
  @IBAction func btnSave(_ sender: Any) {
    
    guard self.validation() else {
      return
    }
    
    FirebaseManager.shared.addChild(image: self.imgUser.image,
                                    name: self.txtName.text ?? "",
                                    dateOfBirth: self.txtDateOfBirth.text ?? "",
                                    relationship: self.txtRelationship.text ?? "")
    
  }
  
}

extension AddChildViewController {
  
  func validation() -> Bool {
    
    guard let _ = self.imgUser.image else {
      self.showSnackbarMessage(message: "Please enter image child",
                               isError: true)
      return false
    }
    
    guard let name = txtName.text,
              name.trimmingCharacters(in: .whitespaces) != "" else {
      self.showSnackbarMessage(message: "Please enter name",
                               isError: true)
      return false
    }
    
    guard let dateOfBirth = txtDateOfBirth.text,
              dateOfBirth.trimmingCharacters(in: .whitespaces) != "" else {
      self.showSnackbarMessage(message: "Please enter date of birth",
                               isError: true)
      return false
    }
    
    guard let relationship = txtRelationship.text,
              relationship.trimmingCharacters(in: .whitespaces) != "" else {
      self.showSnackbarMessage(message: "Please enter relationship",
                               isError: true)
      return false
    }
    
    return true
  }
  
}
