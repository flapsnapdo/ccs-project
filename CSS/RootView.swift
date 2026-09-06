import SwiftUI

struct RootView: View {
    @EnvironmentObject private var sessionManager: SessionManager

    var body: some View {
        Group {
            switch sessionManager.authStep {
            case .phone:
                AuthPhoneView()

            case .code(let phone):
                AuthCodeView(phone: phone)

            case .completeProfile(let phone):
                CompleteProfileView(phone: phone)

            case .authorized:
                MainTabView()
            }
        }
    }
}
