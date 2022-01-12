//
//  ChildrenViewController.swift
//  Jana
//
//  Created by mona M on 01/06/1443 AH.
//

import UIKit

class ChildrenViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var lblChildren: UILabel!
  
  var childrenItems: [ChildModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    fetchData()
    localization ()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  
  @IBAction func btnBack(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  
  @IBAction func btnAdd(_ sender: Any) {
    let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "AddChildViewController")
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
}


extension ChildrenViewController {
  
  
  func setupView() {
    self.tableView.backgroundColor = .clear
    self.tableView.registerCell(nibName: "ChildrenTableViewCell")
  }
  
  
  func localization () {
    lblChildren.text = NSLocalizedString("Children", comment: "")
  }
  
  
  func fetchData() {
    FirebaseManager.shared.getChildren { result in
      self.childrenItems = result
      self.tableView.reloadData()
    }
  }
  
}

extension ChildrenViewController: UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection
                 section: Int) -> Int {
    
    return self.childrenItems.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt
                 indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChildrenTableViewCell",
                                             for: indexPath) as! ChildrenTableViewCell
    
    cell.object = self.childrenItems[indexPath.row]
    cell.configureCell()
    
    return cell
  }
  
}
