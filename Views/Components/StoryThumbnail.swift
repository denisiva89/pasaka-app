// StoryThumbnail.swift
import SwiftUI

struct StoryThumbnail: View {
    let story: Story
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    // Изображение обложки
                    if let coverURL = story.coverURL() {
                        AsyncImage(url: coverURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 200, height: 150)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 200, height: 150)
                                    .cornerRadius(12)
                                    .clipped()
                            case .failure:
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                                    .frame(width: 200, height: 150)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .frame(width: 200, height: 150)
                    }
                    
                    // Значок премиума, если сказка платная
                    if story.isPremium {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Circle().fill(Color.yellow))
                            .padding(12)
                    }
                }
                
                // Название сказки
                Text(story.title)
                    .font(.system(size: 16, weight: .medium))
                    .padding(.top, 4)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .opacity(story.isPremium ? 0.7 : 1.0)
    }
}
