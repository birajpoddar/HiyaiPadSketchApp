import SwiftUI

struct ColoringTemplate: View {
    let art: SketchArt
    var thumbnail = false

    var body: some View {
        Canvas { context, size in
            context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(.white))
            ColoringOutlines.draw(
                art,
                in: &context,
                size: size,
                lineWidth: thumbnail ? max(2, min(size.width, size.height) * 0.018) : max(3.5, min(size.width, size.height) * 0.012)
            )
        }
        .background(Color.white)
        .accessibilityLabel(art.accessibilityName)
    }
}

struct CategoryCover: View {
    let id: String
    var body: some View {
        Text(icon).font(.system(size: 88)).shadow(color: .black.opacity(0.12), radius: 5, y: 4)
    }
    private var icon: String {
        switch id {
        case "rainbow": "🌈"
        case "ocean": "🐳"
        case "space": "🚀"
        case "garden": "🌷"
        case "safari": "🦁"
        case "castle": "🏰"
        case "dino": "🦕"
        default: "🖍️"
        }
    }
}

extension SketchArt {
    var accessibilityName: String {
        rawValue.replacingOccurrences(of: "-", with: " ")
    }
}

/// Black-outline coloring pages in a 0…100 drawing space so every template
/// always renders on iOS 17 (no SF Symbol or asset lookup).
private enum ColoringOutlines {
    static func draw(_ art: SketchArt, in context: inout GraphicsContext, size: CGSize, lineWidth: CGFloat) {
        let s = Space(size: size)
        let style = StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
        switch art {
        case .rainbow: rainbow(s, &context, style)
        case .cloud: cloud(s, &context, style)
        case .pencil: pencil(s, &context, style)
        case .whale: whale(s, &context, style)
        case .fish: fish(s, &context, style)
        case .turtle: turtle(s, &context, style)
        case .rocket: rocket(s, &context, style)
        case .planet: planet(s, &context, style)
        case .alien: alien(s, &context, style)
        case .flower: flower(s, &context, style)
        case .butterfly: butterfly(s, &context, style)
        case .ladybug: ladybug(s, &context, style)
        case .lion: lion(s, &context, style)
        case .elephant: elephant(s, &context, style)
        case .monkey: monkey(s, &context, style)
        case .unicorn: unicorn(s, &context, style)
        case .castle: castle(s, &context, style)
        case .dragon: dragon(s, &context, style)
        case .dinosaur: dinosaur(s, &context, style)
        case .egg: egg(s, &context, style)
        case .volcano: volcano(s, &context, style)
        case .paintbrush: paintbrush(s, &context, style)
        case .heart: heart(s, &context, style)
        }
    }

    private static func stroke(_ path: Path, _ context: inout GraphicsContext, _ style: StrokeStyle) {
        context.stroke(path, with: .color(.black), style: style)
    }

    private static func rainbow(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        for i in 0..<5 {
            let inset = CGFloat(8 + i * 8)
            var path = Path()
            path.addArc(center: s.p(50, 78), radius: s.x(42 - inset), startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
            stroke(path, &c, st)
        }
        stroke(Path(ellipseIn: s.r(14, 70, 12, 10)), &c, st)
        stroke(Path(ellipseIn: s.r(74, 70, 12, 10)), &c, st)
    }

    private static func cloud(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        stroke(Path(ellipseIn: s.r(68, 18, 22, 22)), &c, st)
        var rays = Path()
        for a in stride(from: 0.0, to: 360.0, by: 45) {
            let rad = a * .pi / 180
            rays.move(to: s.p(79 + 14 * cos(rad), 29 + 14 * sin(rad)))
            rays.addLine(to: s.p(79 + 20 * cos(rad), 29 + 20 * sin(rad)))
        }
        stroke(rays, &c, st)
        stroke(Path(ellipseIn: s.r(18, 42, 28, 22)), &c, st)
        stroke(Path(ellipseIn: s.r(34, 36, 30, 24)), &c, st)
        stroke(Path(ellipseIn: s.r(50, 44, 28, 20)), &c, st)
    }

    private static func pencil(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        var body = Path()
        body.move(to: s.p(32, 18))
        body.addLine(to: s.p(68, 18))
        body.addLine(to: s.p(68, 72))
        body.addLine(to: s.p(50, 90))
        body.addLine(to: s.p(32, 72))
        body.closeSubpath()
        stroke(body, &c, st)
        var band = Path()
        band.move(to: s.p(32, 30))
        band.addLine(to: s.p(68, 30))
        stroke(band, &c, st)
        var ferrule = Path()
        ferrule.move(to: s.p(32, 24))
        ferrule.addLine(to: s.p(68, 24))
        stroke(ferrule, &c, st)
        var wood = Path()
        wood.move(to: s.p(32, 72))
        wood.addLine(to: s.p(68, 72))
        stroke(wood, &c, st)
        stroke(Path(ellipseIn: s.r(44, 12, 12, 10)), &c, st)
    }

    private static func whale(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        stroke(Path(ellipseIn: s.r(12, 38, 58, 32)), &c, st)
        var tail = Path()
        tail.move(to: s.p(70, 52))
        tail.addLine(to: s.p(92, 34))
        tail.addLine(to: s.p(82, 54))
        tail.addLine(to: s.p(92, 72))
        tail.addLine(to: s.p(70, 56))
        stroke(tail, &c, st)
        var fin = Path()
        fin.move(to: s.p(38, 68))
        fin.addLine(to: s.p(48, 86))
        fin.addLine(to: s.p(54, 68))
        stroke(fin, &c, st)
        stroke(Path(ellipseIn: s.r(24, 48, 6, 6)), &c, st)
        var smile = Path()
        smile.addArc(center: s.p(26, 58), radius: s.x(8), startAngle: .degrees(20), endAngle: .degrees(140), clockwise: false)
        stroke(smile, &c, st)
        var spout = Path()
        spout.move(to: s.p(36, 38))
        spout.addLine(to: s.p(34, 22))
        spout.move(to: s.p(36, 38))
        spout.addLine(to: s.p(42, 20))
        stroke(spout, &c, st)
        stroke(Path(ellipseIn: s.r(28, 14, 10, 8)), &c, st)
        stroke(Path(ellipseIn: s.r(40, 12, 10, 8)), &c, st)
    }

    private static func fish(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        stroke(Path(ellipseIn: s.r(18, 38, 50, 28)), &c, st)
        var tail = Path()
        tail.move(to: s.p(68, 52))
        tail.addLine(to: s.p(90, 34))
        tail.addLine(to: s.p(82, 52))
        tail.addLine(to: s.p(90, 70))
        tail.closeSubpath()
        stroke(tail, &c, st)
        var top = Path()
        top.move(to: s.p(40, 38))
        top.addLine(to: s.p(48, 22))
        top.addLine(to: s.p(56, 38))
        stroke(top, &c, st)
        stroke(Path(ellipseIn: s.r(28, 48, 7, 7)), &c, st)
        var gill = Path()
        gill.addArc(center: s.p(36, 52), radius: s.x(6), startAngle: .degrees(-70), endAngle: .degrees(70), clockwise: false)
        stroke(gill, &c, st)
    }

    private static func turtle(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        stroke(Path(ellipseIn: s.r(22, 32, 56, 40)), &c, st)
        stroke(Path(ellipseIn: s.r(32, 40, 36, 24)), &c, st)
        var scutes = Path()
        scutes.move(to: s.p(50, 40)); scutes.addLine(to: s.p(50, 64))
        scutes.move(to: s.p(36, 48)); scutes.addLine(to: s.p(64, 56))
        scutes.move(to: s.p(64, 48)); scutes.addLine(to: s.p(36, 56))
        stroke(scutes, &c, st)
        stroke(Path(ellipseIn: s.r(68, 42, 16, 14)), &c, st)
        stroke(Path(ellipseIn: s.r(76, 46, 4, 4)), &c, st)
        stroke(Path(ellipseIn: s.r(16, 38, 12, 10)), &c, st)
        stroke(Path(ellipseIn: s.r(18, 60, 12, 10)), &c, st)
        stroke(Path(ellipseIn: s.r(70, 62, 12, 10)), &c, st)
        stroke(Path(ellipseIn: s.r(42, 70, 14, 10)), &c, st)
    }

    private static func rocket(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        var body = Path()
        body.move(to: s.p(50, 10))
        body.addLine(to: s.p(68, 42))
        body.addLine(to: s.p(68, 72))
        body.addLine(to: s.p(32, 72))
        body.addLine(to: s.p(32, 42))
        body.closeSubpath()
        stroke(body, &c, st)
        stroke(Path(ellipseIn: s.r(42, 40, 16, 16)), &c, st)
        stroke(Path(ellipseIn: s.r(46, 44, 8, 8)), &c, st)
        var fins = Path()
        fins.move(to: s.p(32, 58)); fins.addLine(to: s.p(16, 78)); fins.addLine(to: s.p(32, 72))
        fins.move(to: s.p(68, 58)); fins.addLine(to: s.p(84, 78)); fins.addLine(to: s.p(68, 72))
        stroke(fins, &c, st)
        var flame = Path()
        flame.move(to: s.p(38, 72)); flame.addLine(to: s.p(50, 92)); flame.addLine(to: s.p(62, 72))
        stroke(flame, &c, st)
    }

    private static func planet(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        stroke(Path(ellipseIn: s.r(22, 28, 56, 48)), &c, st)
        var ring = Path()
        ring.addEllipse(in: s.r(8, 46, 84, 16))
        stroke(ring, &c, st)
        stroke(Path(ellipseIn: s.r(34, 38, 12, 8)), &c, st)
        stroke(Path(ellipseIn: s.r(52, 50, 16, 10)), &c, st)
    }

    private static func alien(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        stroke(Path(ellipseIn: s.r(26, 28, 48, 44)), &c, st)
        stroke(Path(ellipseIn: s.r(32, 42, 14, 18)), &c, st)
        stroke(Path(ellipseIn: s.r(54, 42, 14, 18)), &c, st)
        stroke(Path(ellipseIn: s.r(36, 48, 6, 8)), &c, st)
        stroke(Path(ellipseIn: s.r(58, 48, 6, 8)), &c, st)
        var smile = Path()
        smile.addArc(center: s.p(50, 62), radius: s.x(8), startAngle: .degrees(20), endAngle: .degrees(160), clockwise: false)
        stroke(smile, &c, st)
        var antenna = Path()
        antenna.move(to: s.p(38, 30)); antenna.addLine(to: s.p(30, 14))
        antenna.move(to: s.p(62, 30)); antenna.addLine(to: s.p(70, 14))
        stroke(antenna, &c, st)
        stroke(Path(ellipseIn: s.r(26, 10, 8, 8)), &c, st)
        stroke(Path(ellipseIn: s.r(66, 10, 8, 8)), &c, st)
    }

    private static func flower(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        for i in 0..<6 {
            let a = Double(i) * 60.0 * .pi / 180
            let cx = 50 + 18 * cos(a)
            let cy = 42 + 16 * sin(a)
            stroke(Path(ellipseIn: s.r(cx - 10, cy - 12, 20, 24)), &c, st)
        }
        stroke(Path(ellipseIn: s.r(40, 32, 20, 20)), &c, st)
        var stem = Path()
        stem.move(to: s.p(50, 52)); stem.addLine(to: s.p(50, 88))
        stroke(stem, &c, st)
        var leaf = Path()
        leaf.addEllipse(in: s.r(52, 68, 22, 12))
        stroke(leaf, &c, st)
    }

    private static func butterfly(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        stroke(Path(ellipseIn: s.r(18, 22, 28, 28)), &c, st)
        stroke(Path(ellipseIn: s.r(54, 22, 28, 28)), &c, st)
        stroke(Path(ellipseIn: s.r(20, 50, 26, 22)), &c, st)
        stroke(Path(ellipseIn: s.r(54, 50, 26, 22)), &c, st)
        stroke(Path(ellipseIn: s.r(24, 28, 10, 10)), &c, st)
        stroke(Path(ellipseIn: s.r(66, 28, 10, 10)), &c, st)
        var body = Path()
        body.addEllipse(in: s.r(46, 28, 8, 42))
        stroke(body, &c, st)
        var antenna = Path()
        antenna.move(to: s.p(48, 28)); antenna.addLine(to: s.p(40, 12))
        antenna.move(to: s.p(52, 28)); antenna.addLine(to: s.p(60, 12))
        stroke(antenna, &c, st)
        stroke(Path(ellipseIn: s.r(36, 8, 6, 6)), &c, st)
        stroke(Path(ellipseIn: s.r(58, 8, 6, 6)), &c, st)
    }

    private static func ladybug(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        stroke(Path(ellipseIn: s.r(24, 32, 52, 42)), &c, st)
        var line = Path()
        line.move(to: s.p(50, 32)); line.addLine(to: s.p(50, 74))
        stroke(line, &c, st)
        stroke(Path(ellipseIn: s.r(32, 44, 8, 8)), &c, st)
        stroke(Path(ellipseIn: s.r(60, 44, 8, 8)), &c, st)
        stroke(Path(ellipseIn: s.r(36, 58, 8, 8)), &c, st)
        stroke(Path(ellipseIn: s.r(56, 58, 8, 8)), &c, st)
        stroke(Path(ellipseIn: s.r(38, 22, 24, 18)), &c, st)
        stroke(Path(ellipseIn: s.r(42, 28, 5, 5)), &c, st)
        stroke(Path(ellipseIn: s.r(53, 28, 5, 5)), &c, st)
        var legs = Path()
        legs.move(to: s.p(28, 48)); legs.addLine(to: s.p(14, 42))
        legs.move(to: s.p(26, 58)); legs.addLine(to: s.p(12, 62))
        legs.move(to: s.p(72, 48)); legs.addLine(to: s.p(86, 42))
        legs.move(to: s.p(74, 58)); legs.addLine(to: s.p(88, 62))
        stroke(legs, &c, st)
    }

    private static func lion(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        for i in 0..<10 {
            let a = Double(i) * 36.0 * .pi / 180
            let x = 50 + 32 * cos(a)
            let y = 48 + 30 * sin(a)
            stroke(Path(ellipseIn: s.r(x - 7, y - 8, 14, 16)), &c, st)
        }
        stroke(Path(ellipseIn: s.r(30, 30, 40, 40)), &c, st)
        stroke(Path(ellipseIn: s.r(38, 42, 8, 8)), &c, st)
        stroke(Path(ellipseIn: s.r(54, 42, 8, 8)), &c, st)
        stroke(Path(ellipseIn: s.r(44, 52, 12, 10)), &c, st)
        var smile = Path()
        smile.addArc(center: s.p(50, 58), radius: s.x(8), startAngle: .degrees(20), endAngle: .degrees(160), clockwise: false)
        stroke(smile, &c, st)
        stroke(Path(ellipseIn: s.r(28, 26, 12, 10)), &c, st)
        stroke(Path(ellipseIn: s.r(60, 26, 12, 10)), &c, st)
    }

    private static func elephant(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        stroke(Path(ellipseIn: s.r(28, 30, 48, 36)), &c, st)
        stroke(Path(ellipseIn: s.r(18, 34, 22, 28)), &c, st)
        var trunk = Path()
        trunk.move(to: s.p(32, 58))
        trunk.addCurve(to: s.p(22, 84), control1: s.p(18, 64), control2: s.p(14, 76))
        trunk.addCurve(to: s.p(34, 62), control1: s.p(30, 82), control2: s.p(28, 68))
        stroke(trunk, &c, st)
        stroke(Path(ellipseIn: s.r(40, 42, 7, 7)), &c, st)
        stroke(Path(ellipseIn: s.r(34, 66, 10, 18)), &c, st)
        stroke(Path(ellipseIn: s.r(54, 66, 10, 18)), &c, st)
        var tusk = Path()
        tusk.move(to: s.p(30, 58)); tusk.addLine(to: s.p(18, 66))
        stroke(tusk, &c, st)
    }

    private static func monkey(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        stroke(Path(ellipseIn: s.r(18, 34, 18, 18)), &c, st)
        stroke(Path(ellipseIn: s.r(64, 34, 18, 18)), &c, st)
        stroke(Path(ellipseIn: s.r(28, 30, 44, 44)), &c, st)
        stroke(Path(ellipseIn: s.r(34, 46, 32, 24)), &c, st)
        stroke(Path(ellipseIn: s.r(38, 42, 8, 10)), &c, st)
        stroke(Path(ellipseIn: s.r(54, 42, 8, 10)), &c, st)
        var smile = Path()
        smile.addArc(center: s.p(50, 62), radius: s.x(8), startAngle: .degrees(10), endAngle: .degrees(170), clockwise: false)
        stroke(smile, &c, st)
    }

    private static func unicorn(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        var horn = Path()
        horn.move(to: s.p(58, 18)); horn.addLine(to: s.p(50, 42)); horn.addLine(to: s.p(66, 42))
        horn.closeSubpath()
        stroke(horn, &c, st)
        stroke(Path(ellipseIn: s.r(28, 36, 44, 36)), &c, st)
        stroke(Path(ellipseIn: s.r(24, 32, 14, 14)), &c, st)
        stroke(Path(ellipseIn: s.r(58, 30, 14, 14)), &c, st)
        stroke(Path(ellipseIn: s.r(48, 48, 8, 8)), &c, st)
        var mane = Path()
        mane.move(to: s.p(30, 48))
        mane.addCurve(to: s.p(12, 70), control1: s.p(10, 44), control2: s.p(8, 58))
        mane.move(to: s.p(32, 56))
        mane.addCurve(to: s.p(16, 80), control1: s.p(14, 54), control2: s.p(8, 70))
        stroke(mane, &c, st)
        var smile = Path()
        smile.addArc(center: s.p(52, 60), radius: s.x(8), startAngle: .degrees(20), endAngle: .degrees(150), clockwise: false)
        stroke(smile, &c, st)
    }

    private static func castle(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        var keep = Path()
        keep.addRect(s.r(22, 42, 56, 42))
        stroke(keep, &c, st)
        var left = Path(); left.addRect(s.r(14, 28, 16, 56)); stroke(left, &c, st)
        var right = Path(); right.addRect(s.r(70, 28, 16, 56)); stroke(right, &c, st)
        var merlon = Path()
        merlon.move(to: s.p(14, 28)); merlon.addLine(to: s.p(14, 20)); merlon.addLine(to: s.p(20, 20)); merlon.addLine(to: s.p(20, 28))
        merlon.move(to: s.p(24, 28)); merlon.addLine(to: s.p(24, 20)); merlon.addLine(to: s.p(30, 20)); merlon.addLine(to: s.p(30, 28))
        merlon.move(to: s.p(70, 28)); merlon.addLine(to: s.p(70, 20)); merlon.addLine(to: s.p(76, 20)); merlon.addLine(to: s.p(76, 28))
        merlon.move(to: s.p(80, 28)); merlon.addLine(to: s.p(80, 20)); merlon.addLine(to: s.p(86, 20)); merlon.addLine(to: s.p(86, 28))
        stroke(merlon, &c, st)
        var door = Path(); door.addRoundedRect(in: s.r(42, 58, 16, 26), cornerSize: CGSize(width: s.x(8), height: s.x(8)))
        stroke(door, &c, st)
        stroke(Path(ellipseIn: s.r(30, 50, 8, 10)), &c, st)
        stroke(Path(ellipseIn: s.r(62, 50, 8, 10)), &c, st)
        var flag = Path()
        flag.move(to: s.p(50, 42)); flag.addLine(to: s.p(50, 18))
        flag.addLine(to: s.p(64, 24)); flag.addLine(to: s.p(50, 30))
        stroke(flag, &c, st)
    }

    private static func dragon(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        stroke(Path(ellipseIn: s.r(28, 40, 42, 24)), &c, st)
        stroke(Path(ellipseIn: s.r(62, 34, 20, 16)), &c, st)
        stroke(Path(ellipseIn: s.r(72, 38, 5, 5)), &c, st)
        var wing = Path()
        wing.move(to: s.p(40, 42)); wing.addLine(to: s.p(28, 12)); wing.addLine(to: s.p(58, 30)); wing.addLine(to: s.p(52, 42))
        stroke(wing, &c, st)
        var tail = Path()
        tail.move(to: s.p(28, 52)); tail.addCurve(to: s.p(8, 30), control1: s.p(10, 60), control2: s.p(4, 44))
        stroke(tail, &c, st)
        var legs = Path()
        legs.move(to: s.p(38, 62)); legs.addLine(to: s.p(34, 80))
        legs.move(to: s.p(56, 62)); legs.addLine(to: s.p(60, 80))
        stroke(legs, &c, st)
        var flame = Path()
        flame.move(to: s.p(82, 42)); flame.addLine(to: s.p(96, 36)); flame.addLine(to: s.p(90, 42)); flame.addLine(to: s.p(96, 50)); flame.addLine(to: s.p(82, 44))
        stroke(flame, &c, st)
        stroke(Path(ellipseIn: s.r(18, 22, 10, 10)), &c, st)
    }

    private static func dinosaur(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        var neck = Path()
        neck.move(to: s.p(70, 48))
        neck.addCurve(to: s.p(86, 22), control1: s.p(78, 50), control2: s.p(92, 38))
        stroke(neck, &c, st)
        stroke(Path(ellipseIn: s.r(78, 14, 16, 12)), &c, st)
        stroke(Path(ellipseIn: s.r(86, 18, 4, 4)), &c, st)
        stroke(Path(ellipseIn: s.r(22, 42, 52, 28)), &c, st)
        var tail = Path()
        tail.move(to: s.p(22, 54)); tail.addLine(to: s.p(6, 40)); tail.addLine(to: s.p(22, 60))
        stroke(tail, &c, st)
        var legs = Path()
        legs.move(to: s.p(36, 68)); legs.addLine(to: s.p(32, 88)); legs.addLine(to: s.p(40, 88))
        legs.move(to: s.p(58, 68)); legs.addLine(to: s.p(56, 88)); legs.addLine(to: s.p(64, 88))
        stroke(legs, &c, st)
        var spikes = Path()
        spikes.move(to: s.p(34, 44)); spikes.addLine(to: s.p(38, 30)); spikes.addLine(to: s.p(44, 44))
        spikes.move(to: s.p(48, 42)); spikes.addLine(to: s.p(52, 26)); spikes.addLine(to: s.p(58, 42))
        spikes.move(to: s.p(60, 44)); spikes.addLine(to: s.p(66, 30)); spikes.addLine(to: s.p(70, 46))
        stroke(spikes, &c, st)
    }

    private static func egg(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        stroke(Path(ellipseIn: s.r(28, 18, 44, 64)), &c, st)
        var crack = Path()
        crack.move(to: s.p(28, 48))
        crack.addLine(to: s.p(40, 44))
        crack.addLine(to: s.p(48, 52))
        crack.addLine(to: s.p(58, 42))
        crack.addLine(to: s.p(72, 50))
        stroke(crack, &c, st)
        stroke(Path(ellipseIn: s.r(42, 56, 8, 8)), &c, st)
        stroke(Path(ellipseIn: s.r(54, 58, 8, 8)), &c, st)
        var smile = Path()
        smile.addArc(center: s.p(52, 68), radius: s.x(8), startAngle: .degrees(20), endAngle: .degrees(160), clockwise: false)
        stroke(smile, &c, st)
    }

    private static func volcano(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        var mountain = Path()
        mountain.move(to: s.p(8, 86)); mountain.addLine(to: s.p(38, 32)); mountain.addLine(to: s.p(48, 32))
        mountain.addLine(to: s.p(62, 32)); mountain.addLine(to: s.p(92, 86)); mountain.closeSubpath()
        stroke(mountain, &c, st)
        var crater = Path()
        crater.addEllipse(in: s.r(38, 26, 24, 10))
        stroke(crater, &c, st)
        var lava = Path()
        lava.move(to: s.p(50, 26)); lava.addLine(to: s.p(46, 8)); lava.move(to: s.p(50, 26)); lava.addLine(to: s.p(56, 6))
        lava.move(to: s.p(50, 26)); lava.addLine(to: s.p(62, 12))
        stroke(lava, &c, st)
        stroke(Path(ellipseIn: s.r(40, 8, 10, 8)), &c, st)
        stroke(Path(ellipseIn: s.r(54, 4, 12, 8)), &c, st)
    }

    private static func paintbrush(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        var handle = Path()
        handle.addRoundedRect(in: s.r(42, 28, 16, 52), cornerSize: CGSize(width: s.x(4), height: s.x(4)))
        stroke(handle, &c, st)
        var ferrule = Path(); ferrule.addRect(s.r(40, 22, 20, 10)); stroke(ferrule, &c, st)
        var bristles = Path()
        bristles.move(to: s.p(40, 22)); bristles.addLine(to: s.p(32, 8)); bristles.addLine(to: s.p(50, 14)); bristles.addLine(to: s.p(68, 8)); bristles.addLine(to: s.p(60, 22))
        stroke(bristles, &c, st)
        stroke(Path(ellipseIn: s.r(44, 72, 12, 16)), &c, st)
    }

    private static func heart(_ s: Space, _ c: inout GraphicsContext, _ st: StrokeStyle) {
        var path = Path()
        path.move(to: s.p(50, 82))
        path.addCurve(to: s.p(16, 38), control1: s.p(50, 68), control2: s.p(16, 62))
        path.addCurve(to: s.p(50, 28), control1: s.p(16, 14), control2: s.p(50, 20))
        path.addCurve(to: s.p(84, 38), control1: s.p(50, 20), control2: s.p(84, 14))
        path.addCurve(to: s.p(50, 82), control1: s.p(84, 62), control2: s.p(50, 68))
        stroke(path, &c, st)
    }

    private struct Space {
        let size: CGSize
        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            CGPoint(x: x / 100 * size.width, y: y / 100 * size.height)
        }
        func r(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) -> CGRect {
            CGRect(x: x / 100 * size.width, y: y / 100 * size.height, width: w / 100 * size.width, height: h / 100 * size.height)
        }
        func x(_ v: CGFloat) -> CGFloat { v / 100 * size.width }
    }
}
