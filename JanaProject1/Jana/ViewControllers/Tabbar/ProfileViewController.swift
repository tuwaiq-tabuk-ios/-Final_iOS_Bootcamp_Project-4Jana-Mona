//
//  ProfileViewController.swift
//  Jana
//
//  Created by mona M on 01/06/1443 AH.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let items: [Constants.Menu] = [.children, .logout]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension ProfileViewController {
    
    func setupView() {
        self.tableView.backgroundColor = .clear
        self.tableView.registerCell(nibName: "MenuTableViewCell")
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
      cell.object = self.items[indexPath.row]
      cell.configureCell()
      return cell
  }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let object = self.items[indexPath.row]
        
        if object == .logout {
            FirebaseManager.shared.logout { success in
                if (success) {
                    
                }
            }
            return
        }
        
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: object.viewControllerName)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
