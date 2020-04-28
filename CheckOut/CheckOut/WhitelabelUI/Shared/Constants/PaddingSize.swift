import Foundation
import UIKit

// MARK: - Typical Height Types

public enum PaddingSize: String, Decodable {
    
    case none = "none"
    case small = "small"
    case medium = "medium"
    case large = "large"
    case xtraLarge = "extra_large"
    
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
