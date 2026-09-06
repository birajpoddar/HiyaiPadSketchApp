import SwiftUI

enum DrawingMode: String, CaseIterable, Identifiable {
    case pencilOnly = "Pencil only"
    case freehand = "Freehand"
    var id: String { rawValue }
}

enum SketchArt: String, CaseIterable {
    case rainbow, cloud, pencil, whale, fish, turtle, rocket, planet, alien
    case flower, butterfly, ladybug, lion, elephant, monkey, unicorn, castle, dragon
    case dinosaur, egg, volcano, paintbrush, heart
}

struct SketchPage: Identifiable, Hashable {
    let id: String
    let title: String
    let category: String
    let art: SketchArt
    let colors: [Color]
}

struct SketchCategory: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let colors: [Color]
    let pages: [SketchPage]

    static let starterPack: [SketchCategory] = [
        .init(id: "rainbow", title: "Rainbow Day", subtitle: "Make it bright", colors: [.pink, .orange], pages: [
            .init(id: "rainbow", title: "Rainbow", category: "Rainbow Day", art: .rainbow, colors: [.pink, .orange]),
            .init(id: "cloud", title: "Happy Clouds", category: "Rainbow Day", art: .cloud, colors: [.pink, .orange]),
            .init(id: "rainbow-pencil", title: "Color Party", category: "Rainbow Day", art: .pencil, colors: [.pink, .orange])
        ]),
        .init(id: "ocean", title: "Ocean Friends", subtitle: "Dive right in", colors: [.cyan, .blue], pages: [
            .init(id: "whale", title: "Happy Whale", category: "Ocean", art: .whale, colors: [.cyan, .blue]),
            .init(id: "fish", title: "Coral Fish", category: "Ocean", art: .fish, colors: [.cyan, .blue]),
            .init(id: "turtle", title: "Sea Turtle", category: "Ocean", art: .turtle, colors: [.cyan, .blue])
        ]),
        .init(id: "space", title: "Space Adventure", subtitle: "To the stars", colors: [.indigo, .purple], pages: [
            .init(id: "rocket", title: "Rocket Ride", category: "Space", art: .rocket, colors: [.indigo, .purple]),
            .init(id: "planet", title: "Ringed Planet", category: "Space", art: .planet, colors: [.indigo, .purple]),
            .init(id: "alien", title: "Friendly Alien", category: "Space", art: .alien, colors: [.indigo, .purple])
        ]),
        .init(id: "garden", title: "Secret Garden", subtitle: "Grow something lovely", colors: [.green, .mint], pages: [
            .init(id: "flower", title: "Big Flower", category: "Secret Garden", art: .flower, colors: [.green, .mint]),
            .init(id: "butterfly", title: "Butterfly", category: "Secret Garden", art: .butterfly, colors: [.green, .mint]),
            .init(id: "ladybug", title: "Ladybug", category: "Secret Garden", art: .ladybug, colors: [.green, .mint])
        ]),
        .init(id: "safari", title: "Safari Day", subtitle: "Wild colors", colors: [.yellow, .orange], pages: [
            .init(id: "lion", title: "Little Lion", category: "Animals", art: .lion, colors: [.orange, .green]),
            .init(id: "elephant", title: "Big Elephant", category: "Safari Day", art: .elephant, colors: [.yellow, .orange]),
            .init(id: "monkey", title: "Playful Monkey", category: "Safari Day", art: .monkey, colors: [.yellow, .orange])
        ]),
        .init(id: "castle", title: "Cloud Castle", subtitle: "Once upon a time", colors: [.purple, .pink], pages: [
            .init(id: "unicorn", title: "Unicorn", category: "Fairy Tales", art: .unicorn, colors: [.pink, .purple]),
            .init(id: "castle", title: "Cloud Castle", category: "Fairy Tales", art: .castle, colors: [.pink, .purple]),
            .init(id: "dragon", title: "Baby Dragon", category: "Fairy Tales", art: .dragon, colors: [.pink, .purple])
        ]),
        .init(id: "dino", title: "Dino Land", subtitle: "Roar and draw", colors: [.green, .teal], pages: [
            .init(id: "dinosaur", title: "Dinosaur", category: "Dino Land", art: .dinosaur, colors: [.green, .teal]),
            .init(id: "egg", title: "Dino Egg", category: "Dino Land", art: .egg, colors: [.green, .teal]),
            .init(id: "volcano", title: "Volcano", category: "Dino Land", art: .volcano, colors: [.green, .teal])
        ]),
        .init(id: "blank", title: "Blank Page", subtitle: "Anything is possible", colors: [.gray, .blue], pages: [
            .init(id: "blank-pencil", title: "Blank Page", category: "Blank Page", art: .pencil, colors: [.gray, .blue]),
            .init(id: "blank-brush", title: "Paintbrush", category: "Blank Page", art: .paintbrush, colors: [.gray, .blue]),
            .init(id: "blank-heart", title: "Heart", category: "Blank Page", art: .heart, colors: [.gray, .blue])
        ])
    ]
}
