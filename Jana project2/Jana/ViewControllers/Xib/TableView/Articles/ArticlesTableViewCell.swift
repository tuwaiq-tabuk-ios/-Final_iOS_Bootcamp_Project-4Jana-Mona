

import UIKit

class ArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDetials: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var object: ArticleModel?
    
    func configureCell() {
        
        if let obj = self.object {
            self.lblTitle.text = obj.title
        
            if obj.details.count > 250 {
                self.lblDetials.text = obj.details.prefix(250) + " ..."
            } else {
                self.lblDetials.text = obj.details
            }
            
        }
        
    }
    
}
