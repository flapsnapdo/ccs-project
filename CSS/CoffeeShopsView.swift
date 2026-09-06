import SwiftUI
import UIKit

struct CoffeeShopsView: View {
    @State private var selectedCoffeeShop: CoffeeShop?
    @State private var showMapChooser = false

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(SampleData.coffeeShops) { coffeeShop in
                    CoffeeShopRowView(
                        coffeeShop: coffeeShop,
                        onMainTap: {
                            openPreferredMap(for: coffeeShop)
                        },
                        onMoreTap: {
                            selectedCoffeeShop = coffeeShop
                            showMapChooser = true
                        }
                    )
                }
            }
            .padding()
        }
        .background(AppTheme.background.ignoresSafeArea())
        .confirmationDialog(
            "Открыть в картах",
            isPresented: $showMapChooser,
            titleVisibility: .visible
        ) {
            if let coffeeShop = selectedCoffeeShop {
                Button("Яндекс Карты") {
                    openInYandexOrSafari(coffeeShop)
                }

                Button("Apple Maps") {
                    openInAppleMaps(coffeeShop)
                }

                if canOpen2GIS {
                    Button("2GIS") {
                        openIn2GIS(coffeeShop)
                    }
                }
            }

            Button("Отмена", role: .cancel) { }
        } message: {
            if let coffeeShop = selectedCoffeeShop {
                Text(coffeeShop.address)
            }
        }
    }

    private func openPreferredMap(for coffeeShop: CoffeeShop) {
        openInYandexOrSafari(coffeeShop)
    }

    private func openInYandexOrSafari(_ coffeeShop: CoffeeShop) {
        let encodedAddress = coffeeShop.address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        if let yandexAppURL = URL(string: "yandexmaps://maps.yandex.ru/?text=\(encodedAddress)"),
           UIApplication.shared.canOpenURL(yandexAppURL) {
            UIApplication.shared.open(yandexAppURL)
            return
        }

        guard let webURL = URL(string: coffeeShop.mapURL) else { return }
        UIApplication.shared.open(webURL)
    }

    private func openInAppleMaps(_ coffeeShop: CoffeeShop) {
        let encodedAddress = coffeeShop.address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "http://maps.apple.com/?address=\(encodedAddress)") else { return }
        UIApplication.shared.open(url)
    }

    private var canOpen2GIS: Bool {
        guard let url = URL(string: "dgis://") else { return false }
        return UIApplication.shared.canOpenURL(url)
    }

    private func openIn2GIS(_ coffeeShop: CoffeeShop) {
        let encodedAddress = coffeeShop.address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        if let appURL = URL(string: "dgis://2gis.ru/search/\(encodedAddress)"),
           UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
            return
        }

        if let webURL = URL(string: "https://2gis.ru/search/\(encodedAddress)") {
            UIApplication.shared.open(webURL)
        }
    }
}

struct CoffeeShopRowView: View {
    let coffeeShop: CoffeeShop
    let onMainTap: () -> Void
    let onMoreTap: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Button(action: onMainTap) {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title2)
                        .foregroundStyle(AppTheme.accent)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(coffeeShop.address)
                            .font(.headline)
                            .foregroundStyle(AppTheme.textPrimary)
                            .multilineTextAlignment(.leading)

                        Text(coffeeShop.workingHours)
                            .font(.caption)
                            .foregroundStyle(AppTheme.textSecondary)

                        Text("Открыть на карте")
                            .font(.caption)
                            .foregroundStyle(AppTheme.accent)
                            .underline()
                    }

                    Spacer()
                }
            }
            .buttonStyle(.plain)

            Button(action: onMoreTap) {
                Image(systemName: "ellipsis.circle")
                    .font(.title2)
                    .foregroundStyle(AppTheme.accent)
                    .frame(width: 34, height: 34)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(AppTheme.accent.opacity(0.25), lineWidth: 1)
        )
    }
}
