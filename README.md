# Kid Sketchbook

An iPad-only SwiftUI coloring book. Kids pick a themed page, color the outline with a finger or Apple Pencil, and save the result.

Source: [github.com/birajpoddar/HiyaiPadSketchApp](https://github.com/birajpoddar/HiyaiPadSketchApp)

## What is included

- Eight themed books (24 pages): Rainbow Day, Ocean Friends, Space Adventure, Secret Garden, Safari Day, Cloud Castle, Dino Land, and Blank Page.
- Every page is a black outline drawing (rainbow, whale, rocket, flower, and so on) that always shows, including in the page picker.
- Library → book → picture, then a PencilKit canvas over the outline.
- **Finger** (default, works in the simulator) or **Pencil** (Apple Pencil only).
- Large color dots, Marker / Pen / Pencil, three brush sizes, eraser, undo, and redo.
- Drawings save automatically and restore when the page is opened again.
- **Save** writes the outline plus coloring to Photos.
- **Start over** asks before erasing.

## Open and run

1. Open `KidSketchbook.xcodeproj` in Xcode 15 or later (iOS 17, iPad).
2. In **Signing & Capabilities**, select your Apple ID team and replace `com.example.KidSketchbook` with a unique bundle identifier.
3. Choose an iPad simulator, or connect an iPad.
4. Press Run.

You can test in the simulator without a paid developer membership. Leave the mode on **Finger** so a mouse or trackpad can color. On a real iPad, switch to **Pencil** if you want Apple Pencil only.

## Project layout

| Path | Role |
| --- | --- |
| `KidSketchbook/` | App source (models, `DrawingStore`, SwiftUI views) |
| `KidSketchbook.xcodeproj/` | Xcode project |
| `CHANGELOG.md` | Dated log of every project change |
| `LICENSE` | MIT License |

Build products (`work/`, `outputs/`, DerivedData, Xcode user data) are gitignored.

## License

This project is licensed under the [MIT License](LICENSE). Copyright (c) 2026 Biraj Poddar.
