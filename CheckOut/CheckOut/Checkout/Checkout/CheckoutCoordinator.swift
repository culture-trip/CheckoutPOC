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
    
        /* Use this to swap between static data, and injected data driven content examples */
        
        let testingInjection = true
        var injectableSections: [Rows]? = nil
        
        var fileName = "example"
        
        if testingInjection {
            
            fileName = "example_injected_configuration"
            injectableSections = Self.mockedAPI()
        }
        
        /**/
        
        JSONParserWorker.parseJSON(with: fileName, injectableSections: injectableSections) { [weak self] result, error in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.application = result
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
    
    static func mockedAPI() -> [Rows] {
        
        var sections = [Rows]()
        var firstSection = Rows()
        var rows = [Row]()
        
        firstSection.groupKey = "first_injection"
        let firstRow = RowFactory.headerRowInit(content: "Injected Header", alignment: .left, isBordered: false, headerType: .largeHeader)
        let secondRow = RowFactory.paddingInit(height: .medium)
        let thirdRow = RowFactory.bodyTextCellInit(content: "Injected body text", alignment: .left, isBordered: false)
        let fourthRow = RowFactory.paddingInit(height: .large)
        let fifthRow = RowFactory.headerRowInit(content: "Injected subheader", alignment: .left, isBordered: true, headerType: .subHeader)
        let sixthRow = RowFactory.paddingInit(height: .medium)
        let seventhRow = RowFactory.bodyTextCellInit(content: "Injected body text beneath subheader", alignment: .center, isBordered: true)
        let eigthRow = RowFactory.paddingInit(height: .large)
        
        rows.append(firstRow)
        rows.append(secondRow)
        rows.append(thirdRow)
        rows.append(fourthRow)
        rows.append(fifthRow)
        rows.append(sixthRow)
        rows.append(seventhRow)
        rows.append(eigthRow)
        
        firstSection.rows = rows
        
        sections.append(firstSection)
        
        return sections
    }
}
