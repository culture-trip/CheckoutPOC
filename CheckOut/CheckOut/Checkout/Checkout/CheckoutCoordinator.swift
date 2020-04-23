import Foundation
import UIKit

public protocol CheckCoordinating {
    
    init(window: UIWindow?)
    func start()
}

class CheckoutCoordinator {
    
    private weak var window: UIWindow?
    
    init(window: UIWindow?) {
     
        self.window = window
    }
    
    func start() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let view = storyboard.instantiateViewController(identifier: "TableViewController") as? TableViewing else { fatalError() }
        let presenter = TableViewPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        let navigationController = UINavigationController(rootViewController: view as! TableViewController)
        
        navigationController.title = "JSON Configured layout"
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
