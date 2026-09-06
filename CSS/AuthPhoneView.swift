import SwiftUI

struct AuthPhoneView: View {
    @EnvironmentObject private var sessionManager: SessionManager
    @State private var phone = ""

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 40)

                    Image("coffee_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 110)

                    VStack(spacing: 8) {
                        Text("Вход")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(AppTheme.textPrimary)

                        Text("Войди по номеру телефона")
                            .font(.subheadline)
                            .foregroundStyle(AppTheme.textSecondary)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Телефон")
                            .font(.caption)
                            .foregroundStyle(AppTheme.textSecondary)

                        TextField("+7 999 123 45 67", text: $phone)
                            .keyboardType(.phonePad)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .padding()
                            .background(AppTheme.cardBackground)
                            .foregroundStyle(AppTheme.textPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }

                    Button {
                        sessionManager.sendCode(to: phone)
                    } label: {
                        Text("Получить код")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.accent)
                            .foregroundStyle(AppTheme.darkText)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }

                    VStack(spacing: 6) {
                        Text("Макет без сервера")
                            .font(.caption)
                            .foregroundStyle(AppTheme.textSecondary)

                        Text("Тестовый код: 1234")
                            .font(.caption)
                            .foregroundStyle(AppTheme.accent)
                    }

                    if let errorMessage = sessionManager.errorMessage {
                        Text(errorMessage)
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                    }

                    Spacer(minLength: 40)
                }
                .padding()
            }
        }
    }
}
