import Foundation

// MARK: - Model

public enum HeaderType: String, Decodable {
    
    case largeHeader = "large_header"
    case normalHeader = "normal_header"
    case subHeader = "sub_header"
}

public struct Row: Decodable {
    
    let groupKey: String?
    let content: String?
    let title: String?
    let errorTitle: String?
    let height: PaddingSize?
    let type: RowType?
    let alignment: RowAlignmentType?
    let cellInputType: RowInputType?
    let action: Action?
    let isSecure: Bool?
    let isInjected: Bool?
    let isRequired: Bool?
    let isBordered: Bool?
    let headerType: HeaderType?
    
    enum CodingKeys: String, CodingKey {
        
        case content
        case height
        case type
        case alignment
        case cellInputType = "cell_input_type"
        case action
        case isSecure = "is_secure"
        case isInjected = "is_injected"
        case groupKey = "group_key"
        case isRequired = "is_required"
        case title
        case errorTitle = "error_title"
        case isBordered = "is_bordered"
        case headerType = "header_type"
    }
    
    public func updateValues(groupKey: String?, title: String?, errorTitle: String?, content: String?, height: PaddingSize?, type: RowType?, alignment: RowAlignmentType?, cellInputType: RowInputType?, action: Action?, isSecure: Bool?, isRequired: Bool?, headerType: HeaderType?) -> Row {
        
        return Row(groupKey: groupKey ?? self.groupKey, content: content ?? self.content, title: title ?? self.title, errorTitle: errorTitle ?? self.errorTitle, height: height ?? self.height, type: type ?? self.type, alignment: alignment ?? self.alignment, cellInputType: cellInputType ?? self.cellInputType, action: action ?? self.action, isSecure: isSecure ?? self.isSecure, isInjected: isInjected ?? self.isInjected, isRequired: isRequired ?? self.isRequired, isBordered: false, headerType: headerType ?? self.headerType)
    }
}

/* This factory must be kept up to date for all new cells */

public struct RowFactory {
    
    static func inputRowInit(groupKey: String?, title: String?,  placeholder: String?, errorTitle: String?, isSecure: Bool, inputType: RowInputType, isRequired: Bool?) -> Row {
        
        let row = Row(groupKey: groupKey, content: placeholder, title: title, errorTitle: errorTitle, height: nil, type: .inputCell, alignment: nil, cellInputType: inputType, action: nil, isSecure: isSecure, isInjected: true, isRequired: isRequired, isBordered: false, headerType: nil)
        
        return row
    }
    
    static func bodyTextCellInit(groupKey: String?, content: String, alignment: RowAlignmentType, isBordered: Bool) -> Row {
        
        let row = Row(groupKey: groupKey, content: content, title: nil, errorTitle: nil, height: nil, type: .bodyTextCell, alignment: alignment, cellInputType: nil, action: nil, isSecure: nil, isInjected: true, isRequired: false, isBordered: isBordered, headerType: nil)
        
        return row
    }
    
    static func headerRowInit(groupKey: String?, content: String, alignment: RowAlignmentType, isBordered: Bool, headerType: HeaderType) -> Row {
        
        let row = Row(groupKey: groupKey, content: content, title: nil, errorTitle: nil, height: nil, type: .headerCell, alignment: alignment, cellInputType: nil, action: nil, isSecure: nil, isInjected: true, isRequired: false, isBordered: isBordered, headerType: headerType)
        
        return row
    }
    
    static func singleActionInit(groupKey: String?, content: String, action: Action?) -> Row {
        
        let row = Row(groupKey: groupKey, content: content, title: nil, errorTitle: nil, height: nil, type: .singleActionButtonCell, alignment: nil, cellInputType: nil, action: action, isSecure: nil, isInjected: true, isRequired: false, isBordered: false, headerType: nil)
        
        return row
    }
    
    static func paddingInit(groupKey: String?, height: PaddingSize) -> Row {
        
        let row = Row(groupKey: groupKey, content: nil, title: nil, errorTitle: nil, height: height, type: .paddingCell, alignment: nil, cellInputType: nil, action: nil, isSecure: nil, isInjected: true, isRequired: false, isBordered: false, headerType: nil)
        
        return row
    }
}

// MARK: Cell Types

public enum RowType: String, CaseIterable, Decodable {
    
    case headerCell = "header_text_cell"
    case inputCell = "input_cell"
    case bodyTextCell = "body_text_cell"
    case singleActionButtonCell = "single_action_button_cell"
    case paddingCell = "padding_cell"
    case separatorCell = "separator_cell"
    
    func getIdentifier() -> String {
        
        switch self {
        case .headerCell:
            return "HeaderTextCell"
        case .inputCell:
             return "InputCell"
        case .bodyTextCell:
             return "BodyTextCell"
        case .singleActionButtonCell:
             return "SingleActionButtonCell"
        case .paddingCell:
            return "PaddingCell"
        case .separatorCell:
            return "SeparatorCell"
        }
        
    }
}

// MARK: - Cell Input Types

public enum RowInputType: String, Decodable {
    
    case normal
    case numerical
    case name
    case address
    case email
}

// MARK: - Cell Content Alignment types (not just for text)

public enum RowAlignmentType: String, Decodable {
    
    case left
    case right
    case center
}
