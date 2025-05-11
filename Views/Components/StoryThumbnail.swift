import SwiftUI

struct StoryThumbnail: View {
    // Temporarily comment out model dependency
    // let story: Story
    let action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            VStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 200, height: 150)
                    .cornerRadius(12)
                
                Text("Story Title")
                    .font(.system(size: 16, weight: .medium))
                    .padding(.top, 4)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
