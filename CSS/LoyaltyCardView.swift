import SwiftUI

struct LoyaltyCardView: View {
    let user: UserProfile

    var body: some View {
        VStack(spacing: 18) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Бонусная карта")
                        .font(.headline)
                        .foregroundStyle(AppTheme.textPrimary)

                    Text(user.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(AppTheme.textPrimary)
                }

                Spacer()

                Image("coffee_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }

            Image(systemName: "qrcode")
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140)
                .padding()
                .background(AppTheme.lightCard)
                .clipShape(RoundedRectangle(cornerRadius: 16))

            Text("Покажи QR-код на кассе")
                .font(.subheadline)
                .foregroundStyle(AppTheme.textPrimary)

            Text("Пока QR-код используется как заглушка")
                .font(.caption)
                .foregroundStyle(AppTheme.textSecondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [AppTheme.secondaryBackground, AppTheme.background],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(AppTheme.accent, lineWidth: 1.5)
        )
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}
