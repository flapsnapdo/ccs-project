import SwiftUI

enum AppScreen: String, CaseIterable, Identifiable {
    case home = "Главная"
    case menu = "Меню"
    case promotions = "Акции"
    case coffeeShops = "Кофейни"
    case profile = "Профиль"

    var id: String {
        rawValue
    }

    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .menu:
            return "cup.and.saucer.fill"
        case .promotions:
            return "gift.fill"
        case .coffeeShops:
            return "mappin.and.ellipse"
        case .profile:
            return "person.fill"
        }
    }
}

struct MainTabView: View {
    @State private var selectedScreen: AppScreen = .home
    @State private var isMenuOpen = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading) {
                VStack(spacing: 0) {
                    AppHeaderView(isMenuOpen: $isMenuOpen)

                    selectedContent
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(AppTheme.background.ignoresSafeArea())

                if isMenuOpen {
                    Color.black.opacity(0.55)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isMenuOpen = false
                            }
                        }

                    SideMenuView(
                        selectedScreen: $selectedScreen,
                        isMenuOpen: $isMenuOpen
                    )
                    .transition(.move(edge: .leading))
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    @ViewBuilder
    private var selectedContent: some View {
        switch selectedScreen {
        case .home:
            HomeView()
        case .menu:
            MenuView()
        case .promotions:
            PromotionsView()
        case .coffeeShops:
            CoffeeShopsView()
        case .profile:
            ProfileView()
        }
    }
}

struct AppHeaderView: View {
    @Binding var isMenuOpen: Bool

    var body: some View {
        HStack(spacing: 14) {
            Button {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                    isMenuOpen.toggle()
                }
            } label: {
                Image("coffee_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 52, height: 52)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            VStack(alignment: .leading, spacing: 2) {
                Text("COFFEE")
                    .font(.headline)
                    .fontWeight(.black)
                    .foregroundStyle(AppTheme.accent)

                Text("STREET BAR")
                    .font(.headline)
                    .fontWeight(.black)
                    .foregroundStyle(AppTheme.accent)
            }

            Spacer()

            Button {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                    isMenuOpen.toggle()
                }
            } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .foregroundStyle(AppTheme.accent)
                    .frame(width: 44, height: 44)
                    .background(AppTheme.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 12)
        .background(AppTheme.background)
    }
}

struct SideMenuView: View {
    @Binding var selectedScreen: AppScreen
    @Binding var isMenuOpen: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            menuHeader

            VStack(spacing: 10) {
                ForEach(AppScreen.allCases) { screen in
                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                            selectedScreen = screen
                            isMenuOpen = false
                        }
                    } label: {
                        SideMenuRowView(
                            title: screen.rawValue,
                            icon: screen.icon,
                            isSelected: selectedScreen == screen
                        )
                    }
                }
            }

            Spacer()

            Text("Coffee Street Bar")
                .font(.caption)
                .foregroundStyle(AppTheme.textSecondary)
                .padding(.bottom, 20)
        }
        .padding(.top, 60)
        .padding(.horizontal, 18)
        .frame(width: 280)
        .frame(maxHeight: .infinity)
        .background(AppTheme.secondaryBackground)
        .ignoresSafeArea()
    }

    private var menuHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image("coffee_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 16))

            Text("COFFEE STREET BAR")
                .font(.title3)
                .fontWeight(.black)
                .foregroundStyle(AppTheme.accent)

            Text("Меню приложения")
                .font(.subheadline)
                .foregroundStyle(AppTheme.textSecondary)
        }
    }
}

struct SideMenuRowView: View {
    let title: String
    let icon: String
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.headline)
                .frame(width: 26)

            Text(title)
                .font(.headline)

            Spacer()
        }
        .padding()
        .foregroundStyle(isSelected ? AppTheme.darkText : AppTheme.textPrimary)
        .background(isSelected ? AppTheme.accent : AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
