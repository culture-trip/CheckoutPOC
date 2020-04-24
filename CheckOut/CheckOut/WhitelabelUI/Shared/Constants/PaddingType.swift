import Foundation
import UIKit

// MARK: - Typical Height Types

public enum PaddingType: String, Decodable {
    
    case none
    case small
    case medium
    case large
    case xtraLarge
    
    func convertToCGFloat() -> CGFloat {
        switch self {
        case .none: return 0.0
        case .small: return 4.0
        case .medium: return 8.0
        case .large: return 16.0
        case .xtraLarge: return 32.0
        }
    }
}
