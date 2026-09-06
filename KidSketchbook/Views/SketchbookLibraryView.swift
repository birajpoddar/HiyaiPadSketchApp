import SwiftUI

struct SketchbookLibraryView: View {
    private let categories = SketchCategory.starterPack
    private let columns = [GridItem(.adaptive(minimum: 180, maximum: 280), spacing: 22)]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    Text("My Coloring Book").font(.system(.largeTitle, design: .rounded, weight: .bold))
                    LazyVGrid(columns: columns, spacing: 22) {
                        ForEach(categories) { category in
                            NavigationLink(value: category.id) { CategoryCard(category: category) }.buttonStyle(.plain)
                        }
                    }
                }.padding(28)
            }
            .background(Color(.systemGroupedBackground))
            .navigationDestination(for: String.self) { id in
                if let category = categories.first(where: { $0.id == id }) { PagePickerView(category: category) }
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
            }.aspectRatio(1.2, contentMode: .fit).clipShape(RoundedRectangle(cornerRadius: 22))
            Text(category.title).font(.system(.title2, design: .rounded, weight: .bold)).foregroundStyle(.primary)
            Text(category.subtitle).font(.system(.subheadline, design: .rounded)).foregroundStyle(.secondary)
        }.padding(10).background(.background, in: RoundedRectangle(cornerRadius: 28)).shadow(color: .black.opacity(0.1), radius: 12, y: 5)
    }
}

private struct PagePickerView: View {
    let category: SketchCategory
    private let columns = [GridItem(.adaptive(minimum: 170, maximum: 250), spacing: 20)]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(category.pages) { page in
                    NavigationLink(value: page) {
                        VStack(spacing: 10) {
                            ColoringTemplate(art: page.art, thumbnail: true).aspectRatio(0.78, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                .overlay(RoundedRectangle(cornerRadius: 18).stroke(.black.opacity(0.15), lineWidth: 2))
                            Text(page.title).font(.system(.headline, design: .rounded)).foregroundStyle(.primary)
                        }
                    }.buttonStyle(.plain)
                }
            }.padding(24)
        }.navigationTitle(category.title).navigationDestination(for: SketchPage.self) { DrawingView(page: $0) }
    }
}
