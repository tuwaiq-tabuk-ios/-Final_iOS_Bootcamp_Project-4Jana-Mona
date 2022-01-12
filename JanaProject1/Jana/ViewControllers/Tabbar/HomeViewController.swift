
//
//  HomeViewController.swift
//  Jana
//
//  Created by mona M on 18/12/2021.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var coInsideHome: UICollectionView!
  
  @IBOutlet weak var coOutsideHome: UICollectionView!
  
  
  @IBOutlet weak var lblhome: UILabel!
  @IBOutlet weak var lblinsideHome: UILabel!
  @IBOutlet weak var lbloutsideHome: UILabel!
  
  let insideHomeItems: [Constants.sections] = [.kitchen,
                                               .bedrooms,
                                               .bathrooms]
  
  let outsideHomeItems: [Constants.sections] = [.garden,
                                                .restaurant,
                                                .hospital,
                                                .school]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    localization ()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }
  
}

extension HomeViewController {
  
  func setupView() {
    self.coInsideHome.registerCell(nibName: "HomeCellCollectionViewCell")
    self.coOutsideHome.registerCell(nibName: "HomeCellCollectionViewCell")
  }
  
  func localization () {
    lblhome.text = NSLocalizedString("Home", comment: "")
    lblinsideHome.text = NSLocalizedString("Inside Home", comment: "")
    lbloutsideHome.text = NSLocalizedString("Outside Home", comment: "")
    
    
  }
  
  
  
}

extension HomeViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection
                      section: Int) -> Int {
    if collectionView == self.coInsideHome {
      return self.insideHomeItems.count
    } else {
      return self.outsideHomeItems.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt
                      indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == self.coInsideHome {
      let cell = self.coInsideHome.dequeueReusableCell(withReuseIdentifier: "HomeCellCollectionViewCell", for: indexPath) as! HomeCellCollectionViewCell
      cell.object = self.insideHomeItems[indexPath.row]
      cell.configureCell()
      return cell
    } else {
      let cell = self.coOutsideHome.dequeueReusableCell(withReuseIdentifier: "HomeCellCollectionViewCell", for: indexPath) as! HomeCellCollectionViewCell
      cell.object = self.outsideHomeItems[indexPath.row]
      cell.configureCell()
      return cell
    }
  }
  
}

extension HomeViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt
                      indexPath: IndexPath) {
    let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "SectionsDetailsViewController") as! SectionsDetailsViewController
    
    if collectionView == self.coInsideHome {
      vc.object = self.insideHomeItems[indexPath.row]
    } else {
      vc.object = self.outsideHomeItems[indexPath.row]
    }
    
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout
                      collectionViewLayout: UICollectionViewLayout, sizeForItemAt
                      indexPath: IndexPath) -> CGSize {
    
    let width = (collectionView.frame.width - 20) / 3
    let height = (collectionView.frame.height / 2) - 5
    return CGSize(width: width, height: height)
    
  }
  
}
