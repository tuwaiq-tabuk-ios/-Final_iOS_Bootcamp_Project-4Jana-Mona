//
//  ArticlesViewController.swift
//  Jana
//
//  Created by mona M on 18/12/2021.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [ArticleModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension ArticlesViewController {
    
    func setupView() {
        self.tableView.backgroundColor = .clear
        self.tableView.registerCell(nibName: "ArticlesTableViewCell")
    }
    
    
    func fetchData() {
        FirebaseManager.shared.getArticles { result in
            self.items = result
            self.tableView.reloadData()
        }
    }

}

extension ArticlesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesTableViewCell", for: indexPath) as! ArticlesTableViewCell
        cell.object = items[indexPath.row]
        cell.configureCell()
        return cell
    }
    
}

extension ArticlesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as! ArticleDetailsViewController
        vc.object = self.items[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
