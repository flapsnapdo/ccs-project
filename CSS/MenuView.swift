import SwiftUI

struct MenuView: View {
    @State private var selectedCategory: ProductCategory = .coffee

    private var filteredProducts: [Product] {
        SampleData.products.filter { product in
            product.category == selectedCategory
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                categoryScrollView
                productList
            }
            .background(AppTheme.background.ignoresSafeArea())
            .navigationTitle("Меню")
            .toolbarBackground(AppTheme.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    private var categoryScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(ProductCategory.allCases) { category in
                    Button {
                        selectedCategory = category
                    } label: {
                        Text(category.rawValue)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(
                                selectedCategory == category
                                ? AppTheme.accent
                                : AppTheme.cardBackground
                            )
                            .foregroundStyle(
                                selectedCategory == category
                                ? AppTheme.darkText
                                : AppTheme.textPrimary
                            )
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
    }

    private var productList: some View {
        List(filteredProducts) { product in
            NavigationLink {
                ProductDetailView(product: product)
            } label: {
                ProductRowView(product: product)
            }
            .listRowBackground(AppTheme.background)
        }
        .scrollContentBackground(.hidden)
        .background(AppTheme.background)
        .listStyle(.plain)
    }
}

struct ProductRowView: View {
    let product: Product

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: product.imageName)
                .font(.title2)
                .foregroundStyle(AppTheme.accent)
                .frame(width: 52, height: 52)
                .background(AppTheme.accentSoft)
                .clipShape(RoundedRectangle(cornerRadius: 14))

            VStack(alignment: .leading, spacing: 5) {
                Text(product.name)
                    .font(.headline)
                    .foregroundStyle(AppTheme.textPrimary)

                Text(product.description)
                    .font(.caption)
                    .foregroundStyle(AppTheme.textSecondary)
                    .lineLimit(2)
            }

            Spacer()

            Text("от \(product.basePrice) ₽")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(AppTheme.accent)
        }
        .padding(.vertical, 6)
    }
}
