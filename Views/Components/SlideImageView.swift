// SlideImageView.swift
import SwiftUI

struct SlideImageView: View {
    let slide: Slide
    let isLoading: Bool
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .scaleEffect(2.0)
            } else if let imageURL = slide.imageURL() {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .transition(.opacity)
                    case .failure:
                        VStack {
                            Image(systemName: "photo")
                                .font(.system(size: 72))
                                .foregroundColor(.gray)
                            Text("Attēls nav pieejams")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                    @unknown default:
                        EmptyView()
                    }
                }
                .transition(.opacity)
            } else {
                Text("Attēls nav atrasts")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
