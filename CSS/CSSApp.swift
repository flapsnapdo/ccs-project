import SwiftUI

@main
struct CSSApp: App {
    @StateObject private var sessionManager = SessionManager()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(sessionManager)
                .tint(AppTheme.accent)
                .preferredColorScheme(.dark)
        }
    }
}
