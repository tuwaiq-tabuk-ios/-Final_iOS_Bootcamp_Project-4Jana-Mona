
import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension MainNavigationController {
    
    func setupView() {
        AppDelegate.shared.rootNavigationViewController = self
        
        let vcName = "SignInViewController"
        
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: vcName)
        AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
    }
    
 

}
