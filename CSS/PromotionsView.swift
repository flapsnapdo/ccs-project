import SwiftUI

struct PromotionsView: View {
    var body: some View {
        NavigationStack {
            List(SampleData.promos) { promo in
                PromoRowView(promo: promo)
                    .listRowBackground(AppTheme.background)
                    .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            .background(AppTheme.background)
            .navigationTitle("Акции")
            .toolbarBackground(AppTheme.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .listStyle(.plain)
        }
    }
}

struct PromoRowView: View {
    let promo: Promo

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: promo.imageName)
                .font(.title2)
                .foregroundStyle(AppTheme.darkText)
                .frame(width: 56, height: 56)
                .background(AppTheme.accent)
                .clipShape(RoundedRectangle(cornerRadius: 16))

            VStack(alignment: .leading, spacing: 6) {
                Text(promo.title)
                    .font(.headline)
                    .foregroundStyle(AppTheme.textPrimary)

                Text(promo.description)
                    .font(.subheadline)
                    .foregroundStyle(AppTheme.textSecondary)
            }

            Spacer()
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(AppTheme.accent.opacity(0.25), lineWidth: 1)
        )
        .padding(.vertical, 6)
    }
}
