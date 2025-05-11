import SwiftUI

struct MainView: View {
    // Temporarily comment out service dependencies
    // @StateObject private var storyService = StoryService()
    // @StateObject private var audioService = AudioService()
    // @StateObject private var userProgressService = UserProgressService()
    // @StateObject private var storyListViewModel: StoryListViewModel
    
    // @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    Text("Pasaka")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.purple)
                    
                    Spacer()
                    
                    PasakaButton(title: "Sākt", action: {})
                    
                    Button("Informācija vecākiem") {}
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}
