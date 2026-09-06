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
        applyStyle(to: canvas)
        canvas.tool = tool
        canvas.drawingPolicy = drawingMode.canvasPolicy
        canvas.drawing = drawing
        DispatchQueue.main.async { onCanvasReady(canvas) }
        return canvas
    }

    func updateUIView(_ canvas: PKCanvasView, context: Context) {
        context.coordinator.parent = self
        applyStyle(to: canvas)
        canvas.tool = tool
        canvas.drawingPolicy = drawingMode.canvasPolicy
        if canvas.drawing != drawing {
            canvas.drawing = drawing
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    final class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: PencilCanvas
        init(_ parent: PencilCanvas) { self.parent = parent }
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            parent.drawing = canvasView.drawing
        }
    }

    private func applyStyle(to canvas: PKCanvasView) {
        canvas.backgroundColor = .clear
        canvas.isOpaque = false
        canvas.layer.backgroundColor = UIColor.clear.cgColor
        canvas.isScrollEnabled = false
        canvas.minimumZoomScale = 1
        canvas.maximumZoomScale = 1
        canvas.alwaysBounceVertical = false
        canvas.alwaysBounceHorizontal = false
        canvas.bounces = false
        canvas.contentInsetAdjustmentBehavior = .never
        clearBackgrounds(canvas)
    }

    private func clearBackgrounds(_ view: UIView) {
        view.backgroundColor = .clear
        view.isOpaque = false
        view.subviews.forEach { clearBackgrounds($0) }
    }
}
