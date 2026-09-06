import SwiftUI

struct SketchbookLibraryView: View {
    private let categories = SketchCategory.starterPack
    private let columns = [GridItem(.adaptive(minimum: 200, maximum: 320), spacing: 24)]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text("My Coloring Book")
                        .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    Text("Pick a book, then tap a picture to color.")
                        .font(.system(.title3, design: .rounded))
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 12)

                    LazyVGrid(columns: columns, spacing: 22) {
                        ForEach(categories) { category in
                            NavigationLink(value: category.id) {
                                CategoryCard(category: category)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(28)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { id in
                if let category = categories.first(where: { $0.id == id }) {
                    PagePickerView(category: category)
                }
            }
        }
    }
}

private struct CategoryCard: View {
    let category: SketchCategory

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                LinearGradient(colors: category.colors, startPoint: .topLeading, endPoint: .bottomTrailing)
                CategoryCover(id: category.id)
            }
            .aspectRatio(1.25, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))

            Text(category.title)
                .font(.system(.title2, design: .rounded, weight: .bold))
                .foregroundStyle(.primary)
            Text(category.subtitle)
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.secondary)
            Text("\(category.pages.count) pictures")
                .font(.system(.subheadline, design: .rounded, weight: .semibold))
                .foregroundStyle(.secondary)
        }
        .padding(14)
        .background(.background, in: RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 12, y: 6)
        .accessibilityElement(children: .combine)
    }
}

private struct PagePickerView: View {
    let category: SketchCategory
    private let columns = [GridItem(.adaptive(minimum: 180, maximum: 260), spacing: 22)]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 6) {
                Text("Tap a picture to start coloring")
                    .font(.system(.title3, design: .rounded))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 24)
                    .padding(.top, 8)

                LazyVGrid(columns: columns, spacing: 22) {
                    ForEach(category.pages) { page in
                        NavigationLink(value: page) {
                            VStack(spacing: 12) {
                                ColoringTemplate(art: page.art, thumbnail: true)
                                    .aspectRatio(0.78, contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                                            .stroke(.black.opacity(0.12), lineWidth: 2)
                                    )
                                    .shadow(color: .black.opacity(0.06), radius: 8, y: 4)
                                Text(page.title)
                                    .font(.system(.title3, design: .rounded, weight: .semibold))
                                    .foregroundStyle(.primary)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(24)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(category.title)
        .navigationDestination(for: SketchPage.self) { DrawingView(page: $0) }
    }
}
