// StoryMenuView.swift
import SwiftUI

struct StoryMenuView: View {
    @ObservedObject var storyListViewModel: StoryListViewModel
    @Binding var navigationPath: NavigationPath
    @EnvironmentObject var audioService: AudioService
    
    var body: some View {
        ZStack {
            // Фоновый цвет или градиент
            Color.blue.opacity(0.1).ignoresSafeArea()
            
            VStack {
                if storyListViewModel.isLoading {
                    ProgressView("Ielādē stāstus...")
                } else if storyListViewModel.stories.isEmpty {
                    Text("Nav pieejamu stāstu")
                        .font(.title2)
                        .foregroundColor(.gray)
                } else {
                    // Заголовок
                    Text("Izvēlies stāstu")
                        .font(.system(size: 24, weight: .bold))
                        .padding()
                    
                    // Сетка сказок
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 20) {
                            ForEach(storyListViewModel.stories) { story in
                                StoryThumbnail(story: story) {
                                    // При выборе сказки переходим к её просмотру
                                    audioService.stop() // Останавливаем возможное фоновое аудио
                                    
                                    // Если есть прогресс для этой сказки, продолжаем с последнего слайда
                                    var initialSlideIndex = 0
                                    if storyListViewModel.getLastStoryId() == story.id {
                                        initialSlideIndex = storyListViewModel.getLastSlideIndex()
                                    }
                                    
                                    navigationPath.append(NavigationDestination.story(story, initialSlideIndex))
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationTitle("Pasaka")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            storyListViewModel.loadStories()
        }
    }
}
