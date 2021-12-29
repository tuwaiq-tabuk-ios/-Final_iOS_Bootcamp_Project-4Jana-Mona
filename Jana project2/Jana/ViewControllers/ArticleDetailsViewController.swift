
import UIKit

class ArticleDetailsViewController: UIViewController {
  
  @IBOutlet weak var lblTitle: UILabel!
  
  @IBOutlet weak var lblDetials: UILabel!
  
  var object: ArticleModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  @IBAction func btnBack(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
}

extension ArticleDetailsViewController {
  
  func setupView() {
    self.lblTitle.text = self.object?.title
    self.lblDetials.text = self.object?.details
  }
  
  
  
}
