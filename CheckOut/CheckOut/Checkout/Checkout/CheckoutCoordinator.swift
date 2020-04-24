import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    
    func nextScreen()
}

public protocol CheckCoordinating: Coordinator {
    
    init(window: UIWindow?)
    func start()
    func openSuccesfulPaymentScreen()
}

class CheckoutCoordinator: CheckCoordinating {
    
    private weak var window: UIWindow?
    private var application: Application? {
        didSet {
            loadUI()
            screens = application?.screens
        }
    }
    private var screens: [Screen]?
    private var context: UIViewController?
    
    required init(window: UIWindow?) {
        
        self.window = window
    }
    
    func start() {
        
        context = UINavigationController()
        
        window?.rootViewController = context
        window?.makeKeyAndVisible()
        
        JSONParserWorker.parseJSON(with: "example", injectableSections: nil) { [weak self] result, error in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.application = result
            }
        }
    }
    
    private func mockedAPI() -> [Rows] {
        
        var sections = [Rows]()
        var firstSection = Rows()
        var rows = [Row]()
        
        let firstRow = RowFactory.headerRowInit(key: "header", content: "Header", alignment: .left)
        let secondRow = RowFactory.paddingInit(key: "headerPadding", height: .medium)
        let thirdRow = RowFactory.bodyTextCellInit(key: "body", content: "body text", alignment: .left)
        let fourthRow = RowFactory.paddingInit(key: "bodyPadding", height: .medium)
        
        rows.append(firstRow)
        rows.append(secondRow)
        rows.append(thirdRow)
        rows.append(fourthRow)
        
        firstSection.rows = rows
        
        sections.append(firstSection)
        
        return sections
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
        
        let presenter = TableViewPresenter(screen: currentScreen, view: view, coordinator: self)
        
        view.presenter = presenter
        
        guard let viewController = view as? TableViewController else { fatalError() }
        
        pushViewController(viewController)
    }
    
    func openSuccesfulPaymentScreen() {
        
        let viewController = UIViewController()
        
        pushViewController(viewController)
    }
    
    private func pushViewController(_ viewController: UIViewController) {
        
        guard let context = context as? UINavigationController else { fatalError() }
        
        context.pushViewController(viewController, animated: false)
    }
    
    func nextScreen() {
        
    }
}
