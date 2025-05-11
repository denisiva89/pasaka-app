import Foundation

struct MockData {
    static let zeltaZirgsStory: Story = {
        let slides = (1...4).map { index in
            let indexString = String(format: "%02d", index)
            return Slide(
                id: "slide_\(indexString)",
                imageName: "slide\(indexString).png",
                audioName: "slide\(indexString)_audio.m4a"
            )
        }
        
        return Story(
            id: "zelta_zirgs",
            title: "Zelta Zirgs",
            coverImage: "zelta_zirgs_cover.png",
            slides: slides,
            isPremium: false
        )
    }()
    
    static let stories: [Story] = [zeltaZirgsStory]
}
