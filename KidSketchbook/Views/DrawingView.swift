import SwiftUI
import PencilKit
import Photos

struct DrawingView: View {
    let page: SketchPage
    @State private var drawing: PKDrawing
    @State private var tool: PKTool = PKInkingTool(.marker, color: .systemPink, width: 18)
    @State private var canvas: PKCanvasView?
    @State private var drawingMode = DrawingMode.finger
    @State private var inkType: PKInkingTool.InkType = .marker
    @State private var brushWidth: CGFloat = 18
    @State private var selectedColor = UIColor.systemPink
    @State private var showingResetConfirmation = false
    @State private var exportMessage: String?
    @State private var isErasing = false

    private let colors: [UIColor] = [
        .systemRed, .systemPink, .systemOrange, .systemYellow,
        .systemGreen, .systemMint, .systemTeal, .systemBlue,
        .systemPurple, .systemIndigo, .systemBrown, .black, .white
    ]
    private let widths: [CGFloat] = [8, 18, 32]

    init(page: SketchPage) {
        self.page = page
        _drawing = State(initialValue: DrawingStore.drawing(for: page))
    }

    var body: some View {
        VStack(spacing: 0) {
            controls
            ZStack {
                ColoringTemplate(art: page.art)
                    .allowsHitTesting(false)
                PencilCanvas(drawing: $drawing, tool: tool, drawingMode: drawingMode) { canvas = $0 }
            }
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(.black.opacity(0.08), lineWidth: 2)
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(page.title)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: drawing) { _, newValue in DrawingStore.save(newValue, for: page) }
        .confirmationDialog("Erase this picture?", isPresented: $showingResetConfirmation, titleVisibility: .visible) {
            Button("Erase everything", role: .destructive) {
                drawing = PKDrawing()
                DrawingStore.removeDrawing(for: page)
            }
            Button("Keep coloring", role: .cancel) {}
        } message: {
            Text("This cannot be undone.")
        }
        .alert("Saved", isPresented: Binding(get: { exportMessage != nil }, set: { if !$0 { exportMessage = nil } })) {
            Button("OK") { exportMessage = nil }
        } message: {
            Text(exportMessage ?? "")
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Save", systemImage: "square.and.arrow.down") { saveToPhotos() }
                Button("Start over", systemImage: "arrow.counterclockwise") { showingResetConfirmation = true }
            }
        }
    }

    private var controls: some View {
        VStack(alignment: .leading, spacing: 12) {
            Picker("How to draw", selection: $drawingMode) {
                ForEach(DrawingMode.allCases) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            .accessibilityLabel("How to draw")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(colors, id: \.self) { color in
                        Button {
                            selectedColor = color
                            isErasing = false
                            selectInk()
                        } label: {
                            Circle()
                                .fill(Color(color))
                                .frame(width: 44, height: 44)
                                .overlay(
                                    Circle().stroke(Color.black.opacity(color == .white ? 0.35 : 0.12), lineWidth: 1)
                                )
                                .overlay(
                                    Circle().stroke(selectedColor == color && !isErasing ? Color.primary : .clear, lineWidth: 4)
                                )
                        }
                        .accessibilityLabel("Color")
                    }
                }
                .padding(.horizontal, 4)
            }

            HStack(spacing: 10) {
                toolButton("Marker", selected: !isErasing && inkType == .marker) {
                    inkType = .marker; isErasing = false; selectInk()
                }
                toolButton("Pen", selected: !isErasing && inkType == .pen) {
                    inkType = .pen; isErasing = false; selectInk()
                }
                toolButton("Pencil", selected: !isErasing && inkType == .pencil) {
                    inkType = .pencil; isErasing = false; selectInk()
                }
                toolButton("Eraser", selected: isErasing) {
                    isErasing = true
                    tool = PKEraserTool(.vector)
                }
                Spacer(minLength: 8)
                ForEach(widths, id: \.self) { width in
                    Button {
                        brushWidth = width
                        if !isErasing { selectInk() }
                    } label: {
                        Circle()
                            .fill(.primary)
                            .frame(width: max(10, width / 2.2), height: max(10, width / 2.2))
                            .frame(width: 40, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(brushWidth == width ? Color.accentColor : .clear, lineWidth: 3)
                            )
                    }
                    .accessibilityLabel("Brush size")
                }
                Button {
                    canvas?.undoManager?.undo()
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                }
                .accessibilityLabel("Undo")
                Button {
                    canvas?.undoManager?.redo()
                } label: {
                    Image(systemName: "arrow.uturn.forward")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                }
                .accessibilityLabel("Redo")
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(.thinMaterial)
    }

    private func toolButton(_ title: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(title, action: action)
            .font(.system(.headline, design: .rounded))
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(selected ? Color.accentColor.opacity(0.18) : Color.secondary.opacity(0.08), in: Capsule())
            .overlay(Capsule().stroke(selected ? Color.accentColor : .clear, lineWidth: 2))
    }

    private func selectInk() {
        tool = PKInkingTool(inkType, color: selectedColor, width: brushWidth)
    }

    private func saveToPhotos() {
        let exportSize = CGSize(width: 1024, height: 1312)
        let bounds = canvas?.bounds ?? CGRect(origin: .zero, size: exportSize)
        let sourceRect = drawing.bounds.isNull || drawing.bounds.isEmpty ? bounds : bounds
        let marks = drawing.image(from: sourceRect, scale: 2)
        let artwork = ColoringTemplate(art: page.art)
            .frame(width: exportSize.width, height: exportSize.height)
            .overlay {
                Image(uiImage: marks)
                    .resizable()
                    .interpolation(.high)
                    .frame(width: exportSize.width, height: exportSize.height)
            }
        let renderer = ImageRenderer(content: artwork)
        renderer.scale = 2
        guard let image = renderer.uiImage else {
            exportMessage = "Could not make the picture."
            return
        }
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            DispatchQueue.main.async {
                guard status == .authorized || status == .limited else {
                    exportMessage = "Please allow Photos access to save pictures."
                    return
                }
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                exportMessage = "Your picture was saved to Photos!"
            }
        }
    }
}
