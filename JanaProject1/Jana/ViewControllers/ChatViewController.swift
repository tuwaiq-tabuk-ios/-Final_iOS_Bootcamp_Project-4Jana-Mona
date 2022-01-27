//
//  ChatViewController.swift
//  Jana
//
//  Created by mona M on 1/1/2022.
//

import UIKit

class ChatViewController: UIViewController {
  
  @IBOutlet weak var lblPersonName: UILabel!
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var txtMessage: UITextField!
  
  var user: User?
  
  var messages: [Message] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    localization ()
    fetchData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  
  @IBAction func btnBack(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  
  @IBAction func btnSendMessage(_ sender: Any) {
    
    if self.txtMessage.text?.trimmingCharacters(in: .whitespaces) != "" {
      FirebaseManager.shared.addMessage(uidUser: self.user?.udid ?? "",
                                        message: self.txtMessage.text ?? "")
      self.txtMessage.text = ""
    }
    
  }
  

  func setupView() {
    self.lblPersonName.text = self.user?.userName
    
    self.tableView.backgroundColor = .clear
    self.tableView.registerCell(nibName: "ChatTableViewCell")
  }
  
  
  func localization () {
    lblPersonName.text = NSLocalizedString("userName", comment: "")
  }
  
  
  func fetchData() {
    FirebaseManager.shared.getMessages { result in
      self.messages.removeAll()
      
      for value in result {
        if (value.uidUser == UserProfile.shared.currentUser?.udid) || (value.uidSender == UserProfile.shared.currentUser?.udid) {
          
          if (value.uidUser == self.user?.udid || value.uidSender == self.user?.udid) {
            self.messages.append(value)
          }
        }
      }
      self.tableView.reloadData()
    }
  }
  
}



extension ChatViewController: UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection
                 section: Int) -> Int {
    
    return self.messages.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt
                 indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView
      .dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
    cell.object = self.messages[indexPath.row]
    cell.configureCell()
    return cell
  }
  
}
