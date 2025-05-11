// Constants.swift - Константы приложения
import Foundation
import SwiftUI

struct Constants {
    struct Colors {
        static let backgroundColor = Color(red: 0.98, green: 0.97, blue: 0.95) // Светлый бежевый
        static let accentColor = Color(red: 0.35, green: 0.35, blue: 0.8) // Фиолетово-синий
        static let textColor = Color(red: 0.2, green: 0.2, blue: 0.2) // Темно-серый
    }
    
    struct Fonts {
        static let title = Font.system(size: 32, weight: .bold)
        static let heading = Font.system(size: 24, weight: .semibold)
        static let body = Font.system(size: 16, weight: .regular)
        static let button = Font.system(size: 18, weight: .medium)
    }
    
    struct Animations {
        static let defaultDuration: Double = 0.3
        static let slideDuration: Double = 0.5
    }
}
