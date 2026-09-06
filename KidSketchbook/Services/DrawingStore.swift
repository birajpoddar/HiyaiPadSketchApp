import Foundation
import PencilKit

enum DrawingStore {
    private static var directory: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let folder = documents.appendingPathComponent("KidSketchbook", isDirectory: true)
        try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        return folder
    }

    static func drawing(for page: SketchPage) -> PKDrawing {
        let url = directory.appendingPathComponent("\(page.id).drawing")
        guard let data = try? Data(contentsOf: url), let drawing = try? PKDrawing(data: data) else { return PKDrawing() }
        return drawing
    }

    static func save(_ drawing: PKDrawing, for page: SketchPage) {
        let url = directory.appendingPathComponent("\(page.id).drawing")
        try? drawing.dataRepresentation().write(to: url, options: .atomic)
    }

    static func removeDrawing(for page: SketchPage) {
        try? FileManager.default.removeItem(at: directory.appendingPathComponent("\(page.id).drawing"))
    }
}
