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
    let hasSeparators: Bool?
    
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
        case hasSeparators = "has_seperators"
    }
    
    public func updateValues(id: String?, title: String?, sections: [Rows]?, content: String?, type: String?, headerImage: String?, headerText: String?, footerImage: String?, footerText: String?, topContentInset: PaddingType?, bottomContentInset: PaddingType?, hasSeparators: Bool?) -> Screen {
        
        
        return Screen(id: id ?? self.id,
                      title: title ?? self.title,
                      sections: sections ?? self.sections,
                      content: content ?? self.content,
                      type: type ?? self.type,
                      headerImage: headerImage ?? self.headerImage,
                      headerText: headerText ?? self.headerText,
                      footerImage: footerText ?? self.footerImage,
                      footerText: footerText ?? self.footerText,
                      topContentInset: topContentInset ?? self.topContentInset,
                      bottomContentInset: bottomContentInset ?? self.bottomContentInset,
                      hasSeparators: hasSeparators ?? self.hasSeparators)
    }
}
