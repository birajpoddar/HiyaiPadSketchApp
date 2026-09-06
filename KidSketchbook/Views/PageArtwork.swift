import SwiftUI

struct ColoringTemplate: View {
    let art: SketchArt
    var thumbnail = false

    var body: some View {
        ZStack {
            Color.white
            Image(systemName: symbol)
                .resizable().scaledToFit().padding(thumbnail ? 28 : 90)
                .foregroundStyle(.black)
            if art == .whale {
                Text("🐳").font(.system(size: thumbnail ? 42 : 150))
            }
            HStack(spacing: thumbnail ? 8 : 18) {
                ForEach(0..<5, id: \.self) { _ in
                    Circle().stroke(.black, lineWidth: thumbnail ? 2 : 5)
                        .frame(width: thumbnail ? 7 : 18, height: thumbnail ? 7 : 18)
                }
            }.padding(.bottom, thumbnail ? 8 : 30).frame(maxHeight: .infinity, alignment: .bottom)
        }
    }

    private var symbol: String {
        switch art {
        case .rainbow: "rainbow"; case .cloud: "cloud.sun"; case .pencil: "pencil.and.scribble"
        case .whale: "fish.fill"; case .fish: "fish"; case .turtle: "tortoise"; case .rocket: "rocket.fill"
        case .planet: "globe.americas"; case .alien: "face.smiling.inverse"; case .flower: "camera.macro"
        case .butterfly: "butterfly"; case .ladybug: "ladybug"; case .lion: "cat"; case .elephant: "pawprint"
        case .monkey: "pawprint"; case .unicorn: "sparkles"; case .castle: "building.columns"; case .dragon: "flame"
        case .dinosaur: "lizard"; case .egg: "circle.inset.filled"; case .volcano: "mountain.2"
        case .paintbrush: "paintbrush"; case .heart: "heart"
        }
    }
}

struct CategoryCover: View {
    let id: String
    var body: some View {
        Text(icon).font(.system(size: 88)).shadow(color: .black.opacity(0.12), radius: 5, y: 4)
    }
    private var icon: String {
        switch id {
        case "rainbow": "🌈"; case "ocean": "🐳"; case "space": "🚀"; case "garden": "🌷"
        case "safari": "🦁"; case "castle": "🏰"; case "dino": "🦕"; default: "🖍️"
        }
    }
}
