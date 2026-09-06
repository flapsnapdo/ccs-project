import Foundation

struct SampleData {
    static let user = UserProfile(
        name: "Лейла",
        phone: "+7 999 000-00-00",
        email: "example@mail.com",
        bonusBalance: 150,
        cashbackPercent: 5,
        favoriteCoffeeShop: "Кофейня на Арбате"
    )
    
    static let products: [Product] = [
        Product(
            name: "Капучино",
            category: .coffee,
            description: "Классический кофе с молочной пенкой.",
            basePrice: 150,
            imageName: "cup.and.saucer.fill",
            sizes: [
                DrinkSize(name: "S", volume: 300, priceModifier: 0),
                DrinkSize(name: "M", volume: 400, priceModifier: 40),
                DrinkSize(name: "L", volume: 600, priceModifier: 80)
            ]
        ),
        
        Product(
            name: "Латте",
            category: .coffee,
            description: "Мягкий кофейный напиток с большим количеством молока.",
            basePrice: 170,
            imageName: "cup.and.saucer.fill",
            sizes: [
                DrinkSize(name: "S", volume: 300, priceModifier: 0),
                DrinkSize(name: "M", volume: 400, priceModifier: 40),
                DrinkSize(name: "L", volume: 600, priceModifier: 80)
            ]
        ),
        
        Product(
            name: "Американо",
            category: .coffee,
            description: "Крепкий черный кофе без молока.",
            basePrice: 130,
            imageName: "mug.fill",
            sizes: [
                DrinkSize(name: "S", volume: 300, priceModifier: 0),
                DrinkSize(name: "M", volume: 400, priceModifier: 30)
            ]
        ),
        
        Product(
            name: "Матча латте",
            category: .tea,
            description: "Нежный напиток на основе японского чая матча и молока.",
            basePrice: 210,
            imageName: "leaf.fill",
            sizes: [
                DrinkSize(name: "S", volume: 300, priceModifier: 0),
                DrinkSize(name: "M", volume: 400, priceModifier: 50)
            ]
        ),
        
        Product(
            name: "Лимонад клубничный",
            category: .lemonade,
            description: "Освежающий лимонад с клубничным вкусом.",
            basePrice: 190,
            imageName: "takeoutbag.and.cup.and.straw.fill",
            sizes: [
                DrinkSize(name: "M", volume: 400, priceModifier: 0),
                DrinkSize(name: "L", volume: 600, priceModifier: 60)
            ]
        ),
        
        Product(
            name: "Круассан",
            category: .bakery,
            description: "Свежий классический круассан.",
            basePrice: 120,
            imageName: "birthday.cake.fill",
            sizes: []
        ),
        
        Product(
            name: "Чизкейк",
            category: .dessert,
            description: "Нежный десерт с сырным кремом.",
            basePrice: 230,
            imageName: "fork.knife",
            sizes: []
        )
    ]
    
    static let promos: [Promo] = [
        Promo(
            title: "100 бонусов за регистрацию",
            description: "Получи приветственный бонус после создания аккаунта.",
            imageName: "gift.fill"
        ),
        Promo(
            title: "10-й напиток в подарок",
            description: "Покупай напитки и получай каждый 10-й напиток бесплатно.",
            imageName: "star.fill"
        ),
        Promo(
            title: "Бонус в день рождения",
            description: "Специальный подарок для гостей в день рождения.",
            imageName: "party.popper.fill"
        )
    ]
    
    static let coffeeShops: [CoffeeShop] = [
        CoffeeShop(
            name: "",
            address: "Махачкала, улица Имама Шамиля 13В",
            workingHours: "Ежедневно 08:00–22:00",
            metro: nil,
            mapURL: "https://yandex.ru/maps/28/makhachkala/?ll=47.480694%2C42.977563&mode=poi&poi%5Bpoint%5D=47.480758%2C42.977566&poi%5Buri%5D=ymapsbm1%3A%2F%2Forg%3Foid%3D235102573749&z=20.39"
        ),
        CoffeeShop(
            name: "",
            address: "Москва, Арбат, 12",
            workingHours: "Ежедневно 09:00–23:00",
            metro: nil,
            mapURL: "https://yandex.ru/maps/28/makhachkala/?ll=47.480694%2C42.977563&mode=poi&poi%5Bpoint%5D=47.480758%2C42.977566&poi%5Buri%5D=ymapsbm1%3A%2F%2Forg%3Foid%3D235102573749&z=20.39"
        )
    ]
}
