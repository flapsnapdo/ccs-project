import SwiftUI

struct BonusHistoryView: View {
    struct BonusHistoryItem: Identifiable {
        let id = UUID()
        let title: String
        let date: String
        let amount: Int
        let isAccrual: Bool
    }

    private let items: [BonusHistoryItem] = [
        BonusHistoryItem(
            title: "Покупка капучино",
            date: "14 июля",
            amount: 15,
            isAccrual: true
        ),
        BonusHistoryItem(
            title: "Списание бонусов",
            date: "12 июля",
            amount: 50,
            isAccrual: false
        ),
        BonusHistoryItem(
            title: "Покупка десерта",
            date: "10 июля",
            amount: 8,
            isAccrual: true
        )
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(items) { item in
                    HStack(spacing: 14) {
                        Image(systemName: item.isAccrual ? "plus.circle.fill" : "minus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(item.isAccrual ? AppTheme.accent : .red)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .font(.headline)
                                .foregroundStyle(AppTheme.textPrimary)

                            Text(item.date)
                                .font(.caption)
                                .foregroundStyle(AppTheme.textSecondary)
                        }

                        Spacer()

                        Text("\(item.isAccrual ? "+" : "-")\(item.amount)")
                            .font(.headline)
                            .foregroundStyle(item.isAccrual ? AppTheme.accent : .red)
                    }
                    .padding()
                    .background(AppTheme.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                }
            }
            .padding()
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("История бонусов")
        .navigationBarTitleDisplayMode(.inline)
    }
}
