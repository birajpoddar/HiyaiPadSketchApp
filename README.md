# Kid Sketchbook

An iPad-only SwiftUI starter app for kids to create artwork using Apple Pencil.

## Open and run

1. Open `KidSketchbook.xcodeproj` in Xcode 15 or later.
2. In **Signing & Capabilities**, select your Apple ID team and replace `com.example.KidSketchbook` with a unique bundle identifier.
3. Choose an iPad simulator, or connect your iPad and choose it as the run destination.
4. Press Run.

You can test in the simulator without a developer membership. A physical iPad needs to be connected to Xcode and signed with your free Apple ID; App Store distribution later requires the paid Apple Developer Program.

## What is included

- Eight kid-friendly sketch pages with lightweight, editable SwiftUI artwork.
- Apple Pencil-only drawing (`PKCanvasView.drawingPolicy = .pencilOnly`).
- Markers, eraser, undo/redo, and a protected reset confirmation.
- Each page's drawing is saved locally and automatically restored.
