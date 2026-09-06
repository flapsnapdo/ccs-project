import SwiftUI

struct AuthCodeView: View {
    @EnvironmentObject private var sessionManager: SessionManager

    let phone: String
    @State private var code = ""

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 40)

                    Image(systemName: "message.fill")
                        .font(.system(size: 54))
                        .foregroundStyle(AppTheme.accent)

                    VStack(spacing: 8) {
                        Text("Подтверждение")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(AppTheme.textPrimary)

                        Text("Мы отправили код на номер")
                            .font(.subheadline)
                            .foregroundStyle(AppTheme.textSecondary)

                        Text(phone)
                            .font(.headline)
                            .foregroundStyle(AppTheme.accent)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Код из SMS")
                            .font(.caption)
                            .foregroundStyle(AppTheme.textSecondary)

                        TextField("1234", text: $code)
                            .keyboardType(.numberPad)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .padding()
                            .background(AppTheme.cardBackground)
                            .foregroundStyle(AppTheme.textPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }

                    Button {
                        sessionManager.verifyCode(code, for: phone)
                    } label: {
                        Text("Продолжить")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.accent)
                            .foregroundStyle(AppTheme.darkText)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }

                    Button {
                        sessionManager.goBackToPhone()
                    } label: {
                        Text("Изменить номер")
                            .foregroundStyle(AppTheme.textSecondary)
                    }

                    Text("Для макета используй код 1234")
                        .font(.caption)
                        .foregroundStyle(AppTheme.textSecondary)

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
