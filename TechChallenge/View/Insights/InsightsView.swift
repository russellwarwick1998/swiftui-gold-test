//
//  InsightsView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

struct InsightsView: View {
    let transactions: [TransactionModel] = ModelData.sampleTransactions
    let viewModel: InsightsView.ViewModel
    
    var body: some View {
        List {
            RingView(viewModel: viewModel)
                .scaledToFit()
            
            ForEach(TransactionModel.Category.allCases) { category in
                HStack {
                    Text(category.rawValue)
                        .font(.headline)
                        .foregroundColor(category.color)
                    Spacer()
                    // TODO: calculate cummulative expense for each category
                    Text(viewModel.getTotalForCategory(category: category.rawValue), format: .currency(code: "USD"))
                        .bold()
                        .secondary()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Insights")
    }
}

extension InsightsView {
    class ViewModel: ObservableObject {
        
        init(transactions: [TransactionModel]) {
            self.transactions = transactions
        }
        
        let transactions: [TransactionModel]
        
        func getRatioForCategory(category: String) -> Double {
            let all = transactions.map{ $0.amount }.reduce(0, +)
            let filtered = transactions.filter { $0.category.rawValue == category}.map { $0.amount }.reduce(0, +)
            return filtered/all
        }
        
        func getTotalForCategory(category: String) -> Double {
            transactions.filter { $0.category.rawValue == category}.map { $0.amount }.reduce(0, +)
        }
    }
}

#if DEBUG
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView(viewModel: InsightsView.ViewModel(transactions: ModelData.sampleTransactions))
            .previewLayout(.sizeThatFits)
    }
}
#endif
