//
//  ChatUserViewController.swift
//  Jana
//
//  Created by mona M on 18/12/2021.
//

import UIKit

class ChatUserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension ChatUserViewController {
    
    func setupView() {
        self.tableView.backgroundColor = .clear
        self.tableView.registerCell(nibName: "ChatUserTableViewCell")
    }
    
    
    func fetchData() {
        FirebaseManager.shared.getAllUsers { result in
            self.users.removeAll()
            for value in result {
                if value.udid != UserProfile.shared.currentUser?.udid {
                    self.users.append(value)
                }
            }
            self.tableView.reloadData()
        }
    }

}

extension ChatUserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatUserTableViewCell", for: indexPath) as! ChatUserTableViewCell
        cell.object = self.users[indexPath.row]
        cell.configureCell()
        return cell
    }
    
}


extension ChatUserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.user = self.users[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
