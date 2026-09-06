import SwiftUI

struct ProductDetailView: View {
    let product: Product

    @State private var selectedSize: DrinkSize?

    private var finalPrice: Int {
        product.basePrice + (selectedSize?.priceModifier ?? 0)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                productImage
                productInfo

                if !product.sizes.isEmpty {
                    sizePicker
                }

                priceBlock
                noticeBlock
            }
            .padding()
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("Товар")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppTheme.background, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            selectedSize = product.sizes.first
        }
    }

    private var productImage: some View {
        ZStack {
            Circle()
                .fill(AppTheme.accentSoft)
                .frame(width: 180, height: 180)

            Image(systemName: product.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 110, height: 110)
                .foregroundStyle(AppTheme.accent)
        }
        .padding(.top, 24)
    }

    private var productInfo: some View {
        VStack(spacing: 10) {
            Text(product.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(AppTheme.textPrimary)
                .multilineTextAlignment(.center)

            Text(product.description)
                .font(.body)
                .foregroundStyle(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
    }

    private var sizePicker: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Выбери размер")
                .font(.headline)
                .foregroundStyle(AppTheme.textPrimary)

            HStack(spacing: 10) {
                ForEach(product.sizes) { size in
                    Button {
                        selectedSize = size
                    } label: {
                        VStack(spacing: 4) {
                            Text(size.name)
                                .font(.headline)

                            Text("\(size.volume) мл")
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            selectedSize == size
                            ? AppTheme.accent
                            : AppTheme.cardBackground
                        )
                        .foregroundStyle(
                            selectedSize == size
                            ? AppTheme.darkText
                            : AppTheme.textPrimary
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(
                                    selectedSize == size
                                    ? AppTheme.accent
                                    : AppTheme.accent.opacity(0.25),
                                    lineWidth: 1
                                )
                        )
                    }
                }
            }
        }
    }

    private var priceBlock: some View {
        VStack(spacing: 6) {
            Text("\(finalPrice) ₽")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(AppTheme.accent)

            Text("Цена указана для выбранного размера")
                .font(.caption)
                .foregroundStyle(AppTheme.textSecondary)
        }
        .padding(.top, 10)
    }

    private var noticeBlock: some View {
        Text("Онлайн-заказ пока недоступен. Товар можно приобрести в кофейне.")
            .font(.footnote)
            .foregroundStyle(AppTheme.textSecondary)
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppTheme.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(AppTheme.accent.opacity(0.35), lineWidth: 1)
            )
    }
}
