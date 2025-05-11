// StoryPlayerViewModel.swift
import Foundation
import SwiftUI
import Combine

class StoryPlayerViewModel: ObservableObject {
    private let story: Story
    private let audioService: AudioService
    private let userProgressService: UserProgressService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var currentSlideIndex: Int
    @Published var isLoading: Bool = false
    @Published var isAudioPlaying: Bool = false
    @Published var isMuted: Bool = false
    @Published var isTransitioning: Bool = false
    
    var currentSlide: Slide {
        guard currentSlideIndex >= 0 && currentSlideIndex < story.slides.count else {
            // Если индекс вне диапазона, возвращаем первый слайд
            return story.slides.first!
        }
        return story.slides[currentSlideIndex]
    }
    
    var hasNextSlide: Bool {
        return currentSlideIndex < story.slides.count - 1
    }
    
    var hasPreviousSlide: Bool {
        return currentSlideIndex > 0
    }
    
    init(story: Story, audioService: AudioService, userProgressService: UserProgressService, initialSlideIndex: Int = 0) {
        self.story = story
        self.audioService = audioService
        self.userProgressService = userProgressService
        self.currentSlideIndex = initialSlideIndex
        
        // Подписываемся на изменения в AudioService
        audioService.$isPlaying
            .assign(to: \.isAudioPlaying, on: self)
            .store(in: &cancellables)
        
        audioService.$isMuted
            .assign(to: \.isMuted, on: self)
            .store(in: &cancellables)
        
        // Загружаем первый слайд
        loadCurrentSlide()
    }
    
    func loadCurrentSlide() {
        isLoading = true
        
        // Сохраняем прогресс
        userProgressService.saveProgress(storyId: story.id, slideIndex: currentSlideIndex)
        
        // Останавливаем предыдущее аудио
        audioService.stop()
        
        // Задержка для анимации
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            
            // Воспроизводим аудио текущего слайда
            if let audioURL = self.currentSlide.audioURL() {
                self.audioService.play(audioURL: audioURL)
            }
            
            self.isLoading = false
        }
    }
    
    func nextSlide() {
        guard hasNextSlide && !isTransitioning else { return }
        
        isTransitioning = true
        currentSlideIndex += 1
        loadCurrentSlide()
        
        // Завершение перехода
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isTransitioning = false
        }
    }
    
    func previousSlide() {
        guard hasPreviousSlide && !isTransitioning else { return }
        
        isTransitioning = true
        currentSlideIndex -= 1
        loadCurrentSlide()
        
        // Завершение перехода
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isTransitioning = false
        }
    }
    
    func restartAudio() {
        audioService.restart()
    }
    
    func toggleMute() {
        audioService.toggleMute()
    }
}
