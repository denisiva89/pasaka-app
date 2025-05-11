// Slide.swift
import Foundation
import SwiftUI

struct Slide: Identifiable, Equatable {
    let id: String
    let imageName: String
    let audioName: String
    
    init(id: String? = nil, imageName: String, audioName: String) {
            self.id = id ?? UUID().uuidString
            self.imageName = imageName
            self.audioName = audioName
        }
        
        func imageURL(in bundle: Bundle = .main) -> URL? {
            return bundle.url(forResource: imageName, withExtension: nil)
        }
        
        func audioURL(in bundle: Bundle = .main) -> URL? {
            return bundle.url(forResource: audioName, withExtension: nil)
        }
    }
