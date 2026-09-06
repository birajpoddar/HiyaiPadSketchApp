import SwiftUI
import PencilKit

struct PencilCanvas: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    var tool: PKTool
    var drawingMode: DrawingMode
    var onCanvasReady: (PKCanvasView) -> Void

    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.delegate = context.coordinator
        canvas.drawingPolicy = drawingMode == .pencilOnly ? .pencilOnly : .anyInput
        canvas.tool = tool
        canvas.drawingPolicy = drawingMode == .pencilOnly ? .pencilOnly : .anyInput
        canvas.drawing = drawing
        canvas.backgroundColor = .clear
        canvas.isOpaque = false
        canvas.layer.backgroundColor = UIColor.clear.cgColor
        canvas.subviews.forEach { $0.backgroundColor = .clear }
        canvas.alwaysBounceVertical = false
        canvas.alwaysBounceHorizontal = false
        DispatchQueue.main.async { onCanvasReady(canvas) }
        return canvas
    }

    func updateUIView(_ canvas: PKCanvasView, context: Context) {
        canvas.tool = tool
        if canvas.drawing != drawing { canvas.drawing = drawing }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    final class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: PencilCanvas
        init(_ parent: PencilCanvas) { self.parent = parent }
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) { parent.drawing = canvasView.drawing }
    }
}
