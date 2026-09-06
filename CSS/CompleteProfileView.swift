import SwiftUI

struct CompleteProfileView: View {
    @EnvironmentObject private var sessionManager: SessionManager

    let phone: String

    @State private var name = ""
    @State private var email = ""
    @State private var birthDate = Date()
    @State private var agreeToTerms = false

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 30)

                    Image(systemName: "person.crop.circle.badge.plus")
                        .font(.system(size: 56))
                        .foregroundStyle(AppTheme.accent)

                    VStack(spacing: 8) {
                        Text("Создание профиля")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(AppTheme.textPrimary)

                        Text("Номер не найден. Заполни профиль, чтобы завершить регистрацию")
                            .font(.subheadline)
                            .foregroundStyle(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                    }

                    formField(title: "Имя") {
                        TextField("Введите имя", text: $name)
                    }

                    formField(title: "Email") {
                        TextField("example@mail.com", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Дата рождения")
                            .font(.caption)
                            .foregroundStyle(AppTheme.textSecondary)

                        DatePicker(
                            "",
                            selection: $birthDate,
                            displayedComponents: .date
                        )
                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .tint(AppTheme.accent)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(AppTheme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }

                    Toggle(isOn: $agreeToTerms) {
                        Text("Я согласен(а) с условиями программы лояльности")
                            .font(.footnote)
                            .foregroundStyle(AppTheme.textPrimary)
                    }
                    .tint(AppTheme.accent)

                    Button {
                        guard agreeToTerms else {
                            sessionManager.errorMessage = "Подтверди согласие с условиями"
                            return
                        }

                        sessionManager.completeProfile(
                            phone: phone,
                            name: name,
                            email: email,
                            birthDate: birthDate
                        )
                    } label: {
                        Text("Создать профиль")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.accent)
                            .foregroundStyle(AppTheme.darkText)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
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

    @ViewBuilder
    private func formField<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption)
                .foregroundStyle(AppTheme.textSecondary)

            content()
                .padding()
                .background(AppTheme.cardBackground)
                .foregroundStyle(AppTheme.textPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
