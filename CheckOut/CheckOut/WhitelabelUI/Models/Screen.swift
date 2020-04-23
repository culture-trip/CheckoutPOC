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
    let topContentInset: PaddingType?
    let bottomContentInset: PaddingType?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case title
        case sections
        case content
        case type
        case headerImage = "header_image"
        case headerText = "header_text"
        case footerImage = "footer_image"
        case footerText = "footer_text"
        case topContentInset = "top_content_inset"
        case bottomContentInset = "bottom_content_inset"
    }
}
