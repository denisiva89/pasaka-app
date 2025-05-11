// UserProgressService.swift
import Foundation
import SwiftUI

class UserProgressService: ObservableObject {
    private let userDefaults = UserDefaults.standard
    private let lastStoryKey = "lastStoryId"
    private let lastSlideIndexKey = "lastSlideIndex"
    
    func saveProgress(storyId: String, slideIndex: Int) {
        userDefaults.set(storyId, forKey: lastStoryKey)
        userDefaults.set(slideIndex, forKey: lastSlideIndexKey)
    }
    
    func getLastStoryId() -> String? {
        return userDefaults.string(forKey: lastStoryKey)
    }
    
    func getLastSlideIndex() -> Int {
        return userDefaults.integer(forKey: lastSlideIndexKey)
    }
    
    func hasProgress() -> Bool {
        return getLastStoryId() != nil
    }
    
    func clearProgress() {
        userDefaults.removeObject(forKey: lastStoryKey)
        userDefaults.removeObject(forKey: lastSlideIndexKey)
    }
}
