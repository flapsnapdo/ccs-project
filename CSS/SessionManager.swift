import Foundation
import SwiftUI
import Combine

@MainActor
final class SessionManager: ObservableObject {
    enum AuthStep {
        case phone
        case code(phone: String)
        case completeProfile(phone: String)
        case authorized
    }

    @Published var authStep: AuthStep
    @Published var errorMessage: String?

    private let defaults = UserDefaults.standard

    private let isAuthorizedKey = "session.isAuthorized"
    private let authorizedPhoneKey = "session.authorizedPhone"
    private let registeredPhonesKey = "session.registeredPhones"

    init() {
        let defaults = UserDefaults.standard
        let registeredPhonesKey = "session.registeredPhones"

        let defaultPhone = SampleData.user.phone.filter(\.isNumber)
        var phones = Set(defaults.stringArray(forKey: registeredPhonesKey) ?? [])
        phones.insert(defaultPhone)
        defaults.set(Array(phones), forKey: registeredPhonesKey)

        if defaults.bool(forKey: isAuthorizedKey) {
            self.authStep = .authorized
        } else {
            self.authStep = .phone
        }

        self.errorMessage = nil
    }

    func sendCode(to phone: String) {
        let normalized = normalize(phone)

        guard normalized.count >= 10 else {
            errorMessage = "Введи корректный номер телефона"
            return
        }

        errorMessage = nil
        authStep = .code(phone: normalized)
    }

    func verifyCode(_ code: String, for phone: String) {
        let normalizedPhone = normalize(phone)

        guard code == "1234" else {
            errorMessage = "Неверный код. Для макета используй 1234"
            return
        }

        errorMessage = nil

        if loadRegisteredPhones().contains(normalizedPhone) {
            defaults.set(true, forKey: isAuthorizedKey)
            defaults.set(normalizedPhone, forKey: authorizedPhoneKey)
            authStep = .authorized
        } else {
            authStep = .completeProfile(phone: normalizedPhone)
        }
    }

    func completeProfile(
        phone: String,
        name: String,
        email: String,
        birthDate: Date
    ) {
        let normalizedPhone = normalize(phone)

        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Заполни имя"
            return
        }

        var phones = loadRegisteredPhones()
        phones.insert(normalizedPhone)
        saveRegisteredPhones(phones)

        defaults.set(true, forKey: isAuthorizedKey)
        defaults.set(normalizedPhone, forKey: authorizedPhoneKey)

        errorMessage = nil
        authStep = .authorized
    }

    func goBackToPhone() {
        errorMessage = nil
        authStep = .phone
    }

    func logout() {
        defaults.set(false, forKey: isAuthorizedKey)
        defaults.removeObject(forKey: authorizedPhoneKey)
        errorMessage = nil
        authStep = .phone
    }

    private func normalize(_ phone: String) -> String {
        phone.filter(\.isNumber)
    }

    private func loadRegisteredPhones() -> Set<String> {
        let array = defaults.stringArray(forKey: registeredPhonesKey) ?? []
        return Set(array)
    }

    private func saveRegisteredPhones(_ phones: Set<String>) {
        defaults.set(Array(phones), forKey: registeredPhonesKey)
    }
}
