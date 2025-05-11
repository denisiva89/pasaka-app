// Extensions.swift - Полезные расширения
import Foundation
import SwiftUI

// Расширение для View с модификаторами стиля
extension View {
    func pasakaButtonStyle() -> some View {
        self
            .font(Constants.Fonts.button)
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Constants.Colors.accentColor)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            )
    }
    
    func cardStyle() -> some View {
        self
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
            )
            .padding(.horizontal)
    }
}
