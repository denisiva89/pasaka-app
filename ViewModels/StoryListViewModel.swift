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
}
