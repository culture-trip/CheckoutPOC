import Foundation

// MARK: - Typical Height Types

public enum PaddingType: String, Decodable {
    
    case small
    case medium
    case large
    case xtraLarge
    
    func getValue() -> Double {
        switch self {
        case .small: return 4.0
        case .medium: return 8.0
        case .large: return 16.0
        case .xtraLarge: return 32.0
        }
    }
}
