// AudioControlButton.swift
import SwiftUI

struct AudioControlButton: View {
    var icon: String
    var action: () -> Void
    var isActive: Bool = true
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(isActive ? .primary : .gray)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.8))
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                )
        }
    }
}
