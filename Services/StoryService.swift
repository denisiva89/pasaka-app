// StoryService.swift
import Foundation
import SwiftUI

class StoryService: ObservableObject {
    @Published var stories: [Story] = []
    
    init() {
        loadStories()
    }
    
    private func loadStories() {
        // В реальном приложении здесь может быть загрузка из JSON или другого источника
        // Для прототипа используем предопределенные сказки
        stories = MockData.stories
    }
    
    func getStory(withId id: String) -> Story? {
        return stories.first { $0.id == id }
    }
}
