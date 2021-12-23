/*********************		Yousef El-Madhoun		*********************/
//
//  ChatViewController.swift
//  Bidi
//
//  Created by Yousef El-Madhoun on 15/12/2021.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var lblPersonName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var txtMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSendMessage(_ sender: Any) {
    }
    
}

extension ChatViewController {
    
    func setupView() {
        self.tableView.backgroundColor = .clear
        self.tableView.registerCell(nibName: "ChatTableViewCell")
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        
    }

}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
        cell.setUpCell(sender: indexPath.row % 2 == 0 ? .me : .he)
        return cell
    }
    
}
