// NavigationButton.swift
import SwiftUI

struct NavigationButton: View {
    var icon: String
    var action: () -> Void
    var isEnabled: Bool = true
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(isEnabled ? .primary : .gray)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.8))
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                )
        }
        .disabled(!isEnabled)
    }
}
