import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let category: ProductCategory
    let description: String
    let basePrice: Int
    let imageName: String
    let sizes: [DrinkSize]
}

enum ProductCategory: String, CaseIterable, Identifiable {
    case coffee = "Кофе"
    case tea = "Чай"
    case lemonade = "Лимонады"
    case dessert = "Десерты"
    case bakery = "Выпечка"

    var id: String {
        rawValue
    }
}

struct DrinkSize: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let volume: Int
    let priceModifier: Int
}

struct UserProfile {
    var name: String
    var phone: String
    var email: String
    var bonusBalance: Int
    var cashbackPercent: Int
    var favoriteCoffeeShop: String
}

struct Promo: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
}

struct CoffeeShop: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let workingHours: String
    let metro: String?
    let mapURL: String
}
