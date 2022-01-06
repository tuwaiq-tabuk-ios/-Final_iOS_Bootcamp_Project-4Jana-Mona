//
//  SectionsDetailsViewController.swift
//  Jana
//
//  Created by mona M on 1/1/2022.
//

import UIKit

class SectionsDetailsViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var object: Constants.sections?
    
    var tools: [ToolModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        let picker = ImagePicker.shared.picker
        
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                FirebaseManager.shared.addTool(image: photo.image, type: self.object ?? Constants.sections.garden)
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
}

extension SectionsDetailsViewController {
    
    func setupView() {
        self.lblTitle.text = object?.title
        self.collectionView.registerCell(nibName: "ToolCollectionViewCell")
    }
    
    func fetchData() {
        FirebaseManager.shared.getMyTools { data in
            self.tools.removeAll()
            
            for item in data {
                if self.object?.rawValue == item.type {
                    self.tools.append(item)
                }
            }
            
            self.collectionView.reloadData()
        }
    }

}

extension SectionsDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tools.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToolCollectionViewCell", for: indexPath) as! ToolCollectionViewCell
        cell.object = self.tools[indexPath.row]
        cell.configureCell()
        return cell
    }
    
}

extension SectionsDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.frame.width - 20) / 2
        return CGSize(width: size, height: size + 25)
        
    }
    
}
