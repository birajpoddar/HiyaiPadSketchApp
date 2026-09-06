# Kid Sketchbook

An iPad-only SwiftUI coloring book. Kids pick a themed page, color the outline with Apple Pencil or a finger, and save the result.

Source: [github.com/birajpoddar/HiyaiPadSketchApp](https://github.com/birajpoddar/HiyaiPadSketchApp)

## What is included

- Eight themed books (24 pages): Rainbow Day, Ocean Friends, Space Adventure, Secret Garden, Safari Day, Cloud Castle, Dino Land, and Blank Page.
- Library → category → page, then a PencilKit canvas over a coloring template.
- **Pencil only** or **Freehand** (finger, mouse, or Apple Pencil).
- Colors, brush sizes, pen / marker / pencil / crayon / fountain pen, eraser, undo, redo.
- Drawings save automatically to the app documents folder and restore when the page is opened again.
- **Save picture** writes the template plus marks to Photos (permission is requested on first save).
- **Start over** asks before erasing the page.

## Open and run

1. Open `KidSketchbook.xcodeproj` in Xcode 15 or later (iOS 17, iPad).
2. In **Signing & Capabilities**, select your Apple ID team and replace `com.example.KidSketchbook` with a unique bundle identifier.
3. Choose an iPad simulator, or connect an iPad.
4. Press Run.

You can test in the simulator without a paid developer membership. A physical iPad needs a free Apple ID for signing. App Store distribution needs the Apple Developer Program.

Use **Freehand** in the simulator if you do not have Apple Pencil.

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
