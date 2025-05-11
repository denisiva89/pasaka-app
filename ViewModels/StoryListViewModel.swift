// StoryListViewModel.swift
import Foundation
import SwiftUI

class StoryListViewModel: ObservableObject {
    private let storyService: StoryService
    let userProgressService: UserProgressService
    
    @Published var stories: [Story] = []
    @Published var isLoading: Bool = false
    
    init(storyService: StoryService, userProgressService: UserProgressService) {
        self.storyService = storyService
        self.userProgressService = userProgressService
        loadStories()
    }
    
    func loadStories() {
        isLoading = true
        
        // Используем сервис для загрузки историй
        stories = storyService.stories
        
        isLoading = false
    }
    
    func hasProgress() -> Bool {
        return userProgressService.hasProgress()
    }
    
    func getLastStoryId() -> String? {
        return userProgressService.getLastStoryId()
    }
    
    func clearProgress() {
        userProgressService.clearProgress()
    }
    
    // Добавим метод для получения истории по ID
    func getStory(withId id: String) -> Story? {
        return storyService.getStory(withId: id)
    }
    
    // Добавим метод для получения последнего слайда
    func getLastSlideIndex() -> Int {
        return userProgressService.getLastSlideIndex()
    }
}
