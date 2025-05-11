// MainView.swift
import SwiftUI

// Определение NavigationDestination для навигации между экранами
enum NavigationDestination: Hashable {
    case story(Story, Int)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .story(let story, let index):
            hasher.combine(story.id)
            hasher.combine(index)
        }
    }
    
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
        case (.story(let story1, let index1), .story(let story2, let index2)):
            return story1.id == story2.id && index1 == index2
        }
    }
}

struct MainView: View {
    @StateObject private var storyService = StoryService()
    @StateObject private var audioService = AudioService()
    @StateObject private var userProgressService = UserProgressService()
    @StateObject private var storyListViewModel: StoryListViewModel
    
    @State private var navigationPath = NavigationPath()
    
    init() {
        let storyService = StoryService()
        let audioService = AudioService()
        let userProgressService = UserProgressService()

        _storyService = StateObject(wrappedValue: storyService)
        _audioService = StateObject(wrappedValue: audioService)
        _userProgressService = StateObject(wrappedValue: userProgressService)
        _storyListViewModel = StateObject(wrappedValue: StoryListViewModel(
            storyService: storyService,
            userProgressService: userProgressService
        ))
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                // Фоновое изображение или градиент
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // Логотип или название приложения
                    Text("Pasaka")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.purple)
                    
                    Spacer()
                    
                    // Кнопка начала
                    PasakaButton(title: "Sākt") {
                        navigationPath.append("storyMenu")
                    }
                    
                    // Кнопка информации для родителей (заглушка)
                    Button("Informācija vecākiem") {
                        // В будущем здесь будет экран с информацией
                    }
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationDestination(for: String.self) { route in
                switch route {
                case "storyMenu":
                    StoryMenuView(storyListViewModel: storyListViewModel, navigationPath: $navigationPath)
                        .environmentObject(audioService)
                default:
                    EmptyView()
                }
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .story(let story, let initialSlideIndex):
                    // Create the view model
                    let playerViewModel = StoryPlayerViewModel(
                        story: story,
                        audioService: audioService,
                        userProgressService: userProgressService,
                        initialSlideIndex: initialSlideIndex
                    )
                    
                    // Return ONLY the SlideView - no additional parameters after this
                    SlideView(viewModel: playerViewModel) // Error here
                }
            }
        }
        .onAppear {
            // Проверяем наличие сохраненного прогресса при запуске
            if storyListViewModel.hasProgress(),
               let lastStoryId = storyListViewModel.getLastStoryId(),
               let story = storyService.getStory(withId: lastStoryId) {
                
                // Если есть сохраненный прогресс, предлагаем продолжить с последнего места
                // Для прототипа просто автоматически перенаправляем на меню сказок
                navigationPath.append("storyMenu")
            }
        }
    }
}
