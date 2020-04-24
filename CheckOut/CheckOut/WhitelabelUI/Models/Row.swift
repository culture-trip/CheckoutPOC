import Foundation

// MARK: - Model

public struct Row: Decodable {
    
    let key: String?
    let content: String?
    let height: PaddingSize?
    let type: RowType?
    let alignment: RowAlignmentType?
    let cellInputType: RowInputType?
    let action: Action?
    let isSecure: Bool?
    let isInjected: Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case content
        case height
        case type
        case alignment
        case cellInputType = "cell_input_type"
        case action
        case isSecure = "is_secure"
        case isInjected = "is_injected"
        case key
    }
    
    public func updateValues(key: String?, content: String?, height: PaddingSize?, type: RowType?, alignment: RowAlignmentType?, cellInputType: RowInputType?, action: Action?, isSecure: Bool?) -> Row {
        
        return Row(key: key ?? self.key, content: content ?? self.content, height: height ?? self.height, type: type ?? self.type, alignment: alignment ?? self.alignment, cellInputType: cellInputType ?? self.cellInputType, action: action ?? self.action, isSecure: isSecure ?? self.isSecure, isInjected: isInjected ?? self.isInjected)
    }
}

/* This factory must be kept up to date for all new cells */

public struct RowFactory {
    
    static func headerRowInit(key: String?, content: String, alignment: RowAlignmentType) -> Row {
        
        let row = Row(key: key, content: content, height: nil, type: .headerCell, alignment: alignment, cellInputType: nil, action: nil, isSecure: nil, isInjected: true)
        
        return row
    }
    
    static func inputRowInit(key: String?, placeholder: String?, isSecure: Bool, inputType: RowInputType) -> Row {
        
        let row = Row(key: key, content: placeholder, height: nil, type: .inputCell, alignment: nil, cellInputType: inputType, action: nil, isSecure: isSecure, isInjected: true)
        
        return row
    }
    
    static func bodyTextCellInit(key: String?, content: String, alignment: RowAlignmentType) -> Row {
        
        let row = Row(key: key, content: content, height: nil, type: .bodyTextCell, alignment: alignment, cellInputType: nil, action: nil, isSecure: nil, isInjected: true)
        
        return row
    }
    
    static func subHeaderTextInit(key: String?, content: String, alignment: RowAlignmentType) -> Row {
        
        let row = Row(key: key, content: content, height: nil, type: .subHeaderCell, alignment: alignment, cellInputType: nil, action: nil, isSecure: nil, isInjected: true)
        
        return row
    }
    
    static func singleActionInit(key: String?, content: String, action: Action?) -> Row {
        
        let row = Row(key: key, content: content, height: nil, type: .singleActionButtonCell, alignment: nil, cellInputType: nil, action: action, isSecure: nil, isInjected: true)
        
        return row
    }
    
    static func paddingInit(key: String?, height: PaddingSize) -> Row {
        
        let row = Row(key: key, content: nil, height: height, type: .paddingCell, alignment: nil, cellInputType: nil, action: nil, isSecure: nil, isInjected: true)
        
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
    case subHeaderCell = "sub_header_text_cell"
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
        case .subHeaderCell:
            return "SubHeaderTextCell"
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
