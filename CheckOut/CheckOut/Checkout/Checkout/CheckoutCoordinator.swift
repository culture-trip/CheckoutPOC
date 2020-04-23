import Foundation
import UIKit

public protocol CheckCoordinating {
    
    init(window: UIWindow?)
    func start()
}

class CheckoutCoordinator {
    
    private weak var window: UIWindow?
    private var application: Application?
    private var screens: [Screen]?
    private var context: UIViewController?
    
    init(window: UIWindow?) {
        
        self.window = window
    }
    
    func start() {
        
        context = UINavigationController()
                
        window?.rootViewController = context
        window?.makeKeyAndVisible()
        
        ApplicationLoader.parseConfiguration(with: "experiences_checkout") { result, error  in
            
            DispatchQueue.main.async { [weak self] in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self?.application = result
                    self?.loadUI()
                }
            }
        }
    }
    
    private func loadUI() {
        
        var currentScreen: Screen?
        
        guard let screens = application?.screens else { return }
        
        for screen in screens {
            
            if screen.id == "checkout" {
                
                currentScreen = screen
            }
        }
        
        guard currentScreen != nil else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let view = storyboard.instantiateViewController(identifier: "TableViewController") as? TableViewing else { fatalError() }
        
        let presenter = TableViewPresenter(screen: currentScreen)
        
        view.presenter = presenter
        presenter.view = view
        
        guard let context = context as? UINavigationController else { fatalError() }
        guard let viewController = view as? TableViewController else { fatalError() }
        
        context.setViewControllers([viewController], animated: false)
    }
}
