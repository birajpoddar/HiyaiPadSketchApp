# Changelog

All notable changes to Kid Sketchbook are recorded here. Newest entries go under `[Unreleased]`.

## [Unreleased]

### 2026-09-06
#### Fixed
- Every coloring page now draws a real black outline instead of SF Symbols that were blank or wrong (`PageArtwork.swift`).
- Asset catalog is copied as a resource, not a framework (`project.pbxproj`).
- Finger drawing works: canvas defaults to Finger mode and updates Pencil vs Finger when you switch (`PencilCanvas.swift`, `DrawingView.swift`).

#### Changed
- Bigger colors, simpler Marker/Pen/Pencil/Eraser tools, and clearer library copy for kids (`DrawingView.swift`, `SketchbookLibraryView.swift`).
- README matches the outline pages and Finger/Pencil drawing (`README.md`).

#### Added
- MIT license with copyright Biraj Poddar (`LICENSE`, `README.md`).
- Cursor rule requiring a changelog entry for every file change (`.cursor/rules/document-changes.mdc`).
- This changelog as the project change log (`CHANGELOG.md`).
