import Foundation

public struct Screen: Decodable {
    
    let id: String?
    let title: String?
    let sections: [Rows]?
    let content: String?
    let type: String?
    let headerImage: String?
    let headerText: String?
    let footerImage: String?
    let footerText: String?
    let topContentInset: Float?
    let bottomContentInset: Float?
}
