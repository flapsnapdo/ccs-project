import SwiftUI

struct HomeView: View {
    let user = SampleData.user

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                greetingBlock
                LoyaltyCardView(user: user)
                bonusInfoBlock
                seasonalMenuBanner
                promoPreviewBlock
            }
            .padding()
        }
        .background(AppTheme.background.ignoresSafeArea())
    }

    private var greetingBlock: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Привет, \(user.name)!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(AppTheme.textPrimary)

            Text("Что сегодня выпьем?")
                .font(.title3)
                .foregroundStyle(AppTheme.textSecondary)

            Text("Здесь будет твоя бонусная карта, сезонные предложения и любимые напитки.")
                .font(.subheadline)
                .foregroundStyle(AppTheme.textSecondary)
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(AppTheme.accent.opacity(0.25), lineWidth: 1)
        )
    }

    private var seasonalMenuBanner: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Сезонное меню")
                .font(.headline)
                .foregroundStyle(AppTheme.textPrimary)

            ZStack {
                RoundedRectangle(cornerRadius: 22)
                    .fill(AppTheme.cardBackground)

                VStack(spacing: 12) {
                    Image(systemName: "photo")
                        .font(.system(size: 42))
                        .foregroundStyle(AppTheme.accent)

                    Text("Здесь будет баннер сезонного меню")
                        .font(.headline)
                        .foregroundStyle(AppTheme.textPrimary)

                    Text("Позже ты сможешь добавить сюда свою картинку")
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
            }
            .frame(height: 220)
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(style: StrokeStyle(lineWidth: 1.2, dash: [8]))
                    .foregroundStyle(AppTheme.accent.opacity(0.5))
            )
        }
    }

    private var bonusInfoBlock: some View {
        HStack(spacing: 16) {
            InfoCardView(
                title: "Бонусы",
                value: "\(user.bonusBalance)",
                icon: "sparkles"
            )

            InfoCardView(
                title: "Кешбэк",
                value: "\(user.cashbackPercent)%",
                icon: "percent"
            )
        }
    }

    private var promoPreviewBlock: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Акция дня")
                .font(.headline)
                .foregroundStyle(AppTheme.textPrimary)

            VStack(alignment: .leading, spacing: 8) {
                Text("10-й напиток в подарок")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(AppTheme.darkText)

                Text("Покупай любимые напитки и получай подарки.")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.75))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(AppTheme.accent)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

struct InfoCardView: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(AppTheme.accent)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(AppTheme.textPrimary)

            Text(title)
                .font(.caption)
                .foregroundStyle(AppTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

