import SwiftUI

struct StoryMenuView: View {
    // Temporarily comment out ViewModel dependencies
    // @ObservedObject var storyListViewModel: StoryListViewModel
    // @Binding var navigationPath: NavigationPath
    // @EnvironmentObject var audioService: AudioService
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea()
            
            VStack {
                Text("Izvēlies stāstu")
                    .font(.system(size: 24, weight: .bold))
                    .padding()
                
                Text("Story menu placeholder")
            }
        }
        .navigationTitle("Pasaka")
        .navigationBarTitleDisplayMode(.inline)
    }
}
