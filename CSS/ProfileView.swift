import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var sessionManager: SessionManager

    @State private var name = SampleData.user.name
    @State private var phone = SampleData.user.phone
    @State private var email = SampleData.user.email
    @State private var favoriteCoffeeShop = SampleData.user.favoriteCoffeeShop

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                profileHeader
                personalInfoSection
                loyaltySection
                extraSection
                appInfoSection
                logoutButton
            }
            .padding()
        }
        .background(AppTheme.background.ignoresSafeArea())
    }

    private var profileHeader: some View {
        VStack(spacing: 12) {
            Image("coffee_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)

            Text(name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(AppTheme.textPrimary)

            Text("Гость Coffee Street Bar")
                .font(.subheadline)
                .foregroundStyle(AppTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(AppTheme.accent.opacity(0.35), lineWidth: 1)
        )
    }

    private var personalInfoSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle("Личные данные")

            CustomTextField(title: "Имя", text: $name)
            CustomTextField(title: "Телефон", text: $phone)
            CustomTextField(title: "Email", text: $email)

            VStack(alignment: .leading, spacing: 8) {
                Text("Любимая кофейня")
                    .font(.caption)
                    .foregroundStyle(AppTheme.textSecondary)

                Picker("Любимая кофейня", selection: $favoriteCoffeeShop) {
                    ForEach(SampleData.coffeeShops) { coffeeShop in
                        Text(coffeeShop.address)
                            .tag(coffeeShop.address)
                    }
                }
                .tint(AppTheme.accent)
                .padding()
                .background(AppTheme.secondaryBackground)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    private var loyaltySection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle("Бонусная программа")

            ProfileInfoRow(title: "Бонусы", value: "\(SampleData.user.bonusBalance)")
            ProfileInfoRow(title: "Кешбэк", value: "\(SampleData.user.cashbackPercent)%")
            ProfileInfoRow(title: "Статус", value: "Гость")
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    private var extraSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle("Дополнительно")

            NavigationLink {
                BonusHistoryView()
            } label: {
                HStack {
                    Text("История бонусов")
                        .foregroundStyle(AppTheme.textPrimary)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundStyle(AppTheme.accent)
                }
                .padding()
                .background(AppTheme.secondaryBackground)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    private var appInfoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle("О приложении")

            Text("Это прототип приложения для кофейни.")
                .foregroundStyle(AppTheme.textSecondary)

            Text("Реальные бонусы, SMS-коды и данные профиля позже будут подключены через backend.")
                .foregroundStyle(AppTheme.textSecondary)
        }
        .font(.subheadline)
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    private var logoutButton: some View {
        Button {
            sessionManager.logout()
        } label: {
            Text("Выйти из аккаунта")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.red.opacity(0.18))
                .foregroundStyle(.red)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundStyle(AppTheme.accent)
    }
}

struct CustomTextField: View {
    let title: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundStyle(AppTheme.textSecondary)

            TextField(title, text: $text)
                .foregroundStyle(AppTheme.textPrimary)
                .tint(AppTheme.accent)
                .padding()
                .background(AppTheme.secondaryBackground)
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

struct ProfileInfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(AppTheme.textPrimary)

            Spacer()

            Text(value)
                .fontWeight(.semibold)
                .foregroundStyle(AppTheme.accent)
        }
        .font(.subheadline)
        .padding()
        .background(AppTheme.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
