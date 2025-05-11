import Foundation
import SwiftUI

struct Story: Identifiable {
    let id: String
    let title: String
    let coverImage: String
    let slides: [Slide]
    let isPremium: Bool
    
    init(id: String? = nil, title: String, coverImage: String, slides: [Slide], isPremium: Bool = false) {
        self.id = id ?? UUID().uuidString
        self.title = title
        self.coverImage = coverImage
        self.slides = slides
        self.isPremium = isPremium
    }
    
    func coverURL(in bundle: Bundle = .main) -> URL? {
        return bundle.url(forResource: coverImage, withExtension: nil)
    }
}
