// SlideView.swift
import SwiftUI

struct SlideView: View {
    @ObservedObject var viewModel: StoryPlayerViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            // Черный фон для лучшего контраста при просмотре слайдов
            Color.black.ignoresSafeArea()
            
            // Изображение слайда
            SlideImageView(slide: viewModel.currentSlide, isLoading: viewModel.isLoading)
                .opacity(viewModel.isTransitioning ? 0.5 : 1.0)
                .animation(.easeInOut(duration: 0.3), value: viewModel.isTransitioning)
            
            // Элементы управления
            VStack {
                Spacer()
                
                // Нижняя панель управления
                HStack {
                    // Кнопка назад
                    NavigationButton(
                        icon: "chevron.backward",
                        action: { viewModel.previousSlide() },
                        isEnabled: viewModel.hasPreviousSlide
                    )
                    
                    Spacer()
                    
                    // Кнопка перезапуска аудио
                    AudioControlButton(
                        icon: "arrow.clockwise",
                        action: { viewModel.restartAudio() }
                    )
                    
                    // Кнопка выключения звука
                    AudioControlButton(
                        icon: viewModel.isMuted ? "speaker.slash.fill" : "speaker.fill",
                        action: { viewModel.toggleMute() },
                        isActive: !viewModel.isMuted
                    )
                    
                    Spacer()
                    
                    // Кнопка вперед
                    NavigationButton(
                        icon: "chevron.forward",
                        action: { viewModel.nextSlide() },
                        isEnabled: viewModel.hasNextSlide
                    )
                }
                .padding()
                .background(
                    Rectangle()
                        .fill(Color.black.opacity(0.5))
                        .ignoresSafeArea()
                )
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                viewModel.audioService.stop()
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Atpakaļ")
                }
                .foregroundColor(.white)
            }
        )
        .onAppear {
            // Загружаем и воспроизводим текущий слайд при открытии экрана
            viewModel.loadCurrentSlide()
        }
        .onDisappear {
            // Останавливаем аудио при уходе с экрана
            viewModel.audioService.stop()
        }
        // Добавляем жесты для навигации между слайдами
        .gesture(
            DragGesture(minimumDistance: 50)
                .onEnded { value in
                    if value.translation.width > 0 && viewModel.hasPreviousSlide {
                        // Свайп вправо - предыдущий слайд
                        viewModel.previousSlide()
                    } else if value.translation.width < 0 && viewModel.hasNextSlide {
                        // Свайп влево - следующий слайд
                        viewModel.nextSlide()
                    }
                }
        )
    }
}
