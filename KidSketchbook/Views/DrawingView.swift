import SwiftUI
import PencilKit
import Photos

struct DrawingView: View {
    let page: SketchPage
    @State private var drawing: PKDrawing
    @State private var tool: PKTool = PKInkingTool(.marker, color: .systemPink, width: 14)
    @State private var canvas: PKCanvasView?
    @State private var drawingMode = DrawingMode.pencilOnly
    @State private var inkType: PKInkingTool.InkType = .marker
    @State private var brushWidth: CGFloat = 14
    @State private var selectedColor = UIColor.systemPink
    @State private var showingResetConfirmation = false
    @State private var exportMessage: String?
    private let colors: [UIColor] = [.systemRed, .systemPink, .systemPurple, .systemIndigo, .systemBlue, .systemTeal, .systemGreen, .systemMint, .systemYellow, .systemOrange, .systemBrown, .black, .darkGray, .white]
    private let widths: [CGFloat] = [4, 8, 14, 22, 34]

    init(page: SketchPage) {
        self.page = page
        _drawing = State(initialValue: DrawingStore.drawing(for: page))
    }

    var body: some View {
        VStack(spacing: 0) {
            controls
            ZStack {
                ColoringTemplate(art: page.art)
                PencilCanvas(drawing: $drawing, tool: tool, drawingMode: drawingMode) { canvas = $0 }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding(18)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(page.title).navigationBarTitleDisplayMode(.inline)
        .onChange(of: drawing) { _, newValue in DrawingStore.save(newValue, for: page) }
        .confirmationDialog("Start this page over?", isPresented: $showingResetConfirmation) {
            Button("Erase Everything", role: .destructive) { drawing = PKDrawing(); DrawingStore.removeDrawing(for: page) }
        }
        .alert("Saved", isPresented: Binding(get: { exportMessage != nil }, set: { if !$0 { exportMessage = nil } })) {
            Button("OK") { exportMessage = nil }
        } message: { Text(exportMessage ?? "") }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Save picture", systemImage: "square.and.arrow.down") { saveToPhotos() }
                Button("Start over", systemImage: "arrow.counterclockwise") { showingResetConfirmation = true }
            }
        }
    }

    private var controls: some View {
        VStack(spacing: 10) {
            Picker("Drawing mode", selection: $drawingMode) {
                ForEach(DrawingMode.allCases) { Text($0.rawValue).tag($0) }
            }.pickerStyle(.segmented).padding(.horizontal, 18)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(colors, id: \.self) { color in
                        Button {
                            selectedColor = color
                            selectInk()
                        } label: {
                            Circle().fill(Color(color)).frame(width: 31, height: 31)
                                .overlay(Circle().stroke(selectedColor == color ? Color.primary : .clear, lineWidth: 3))
                        }.accessibilityLabel("Color")
                    }
                    Divider().frame(height: 32)
                    ForEach([PKInkingTool.InkType.pen, .marker, .pencil, .crayon, .fountainPen], id: \.self) { type in
                        Button(inkName(type)) { inkType = type; selectInk() }
                            .buttonStyle(.bordered).tint(inkType == type ? .blue : .gray)
                    }
                    Divider().frame(height: 32)
                    ForEach(widths, id: \.self) { width in
                        Button { brushWidth = width; selectInk() } label: {
                            Circle().fill(.primary).frame(width: max(5, width / 1.6), height: max(5, width / 1.6))
                                .frame(width: 35, height: 35)
                        }.buttonStyle(.bordered).tint(brushWidth == width ? .blue : .gray)
                    }
                    Button { tool = PKEraserTool(.vector) } label: { Image(systemName: "eraser.fill") }.buttonStyle(.bordered)
                    Button { canvas?.undoManager?.undo() } label: { Image(systemName: "arrow.uturn.backward") }.buttonStyle(.bordered)
                    Button { canvas?.undoManager?.redo() } label: { Image(systemName: "arrow.uturn.forward") }.buttonStyle(.bordered)
                }.padding(.horizontal, 18)
            }
        }.padding(.vertical, 10).background(.thinMaterial)
    }

    private func selectInk() {
        tool = PKInkingTool(inkType, color: selectedColor, width: brushWidth)
    }

    private func inkName(_ type: PKInkingTool.InkType) -> String {
        if type == .pen { return "Pen" }
        if type == .marker { return "Marker" }
        if type == .pencil { return "Pencil" }
        if type == .crayon { return "Crayon" }
        return "Fountain"
    }

    private func saveToPhotos() {
        let canvasBounds = canvas?.bounds ?? CGRect(x: 0, y: 0, width: 1024, height: 1300)
        let marks = drawing.image(from: canvasBounds, scale: 2)
        let artwork = ColoringTemplate(art: page.art)
            .frame(width: 1024, height: 1300)
            .overlay(Image(uiImage: marks).resizable().scaledToFill().frame(width: 1024, height: 1300))
        let renderer = ImageRenderer(content: artwork)
        renderer.scale = 2
        guard let image = renderer.uiImage else { exportMessage = "Could not make the picture."; return }
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            DispatchQueue.main.async {
                guard status == .authorized || status == .limited else { exportMessage = "Please allow Photos access to save pictures."; return }
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                exportMessage = "Your colored picture was saved to Photos!"
            }
        }
    }
}
