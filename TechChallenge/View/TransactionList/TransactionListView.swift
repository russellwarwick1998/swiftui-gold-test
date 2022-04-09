//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    
    @StateObject private var viewModel = ViewModel(transactions: ModelData.sampleTransactions)
        
    var body: some View {
        ZStack {
            VStack {
                CategoriesView(categories: viewModel.categories) { viewModel.categorySelected = $0 }
                List {
                    ForEach(viewModel.filteredTransactions) { TransactionView(transaction: $0) }
                    Spacer(minLength: 100)
                }
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Transactions")
            }
            VStack {
                Spacer()
                FloatingView(total: viewModel.categoryTotal, category: viewModel.categorySelected).frame(height: 100)
            }
        }
    }
}

extension TransactionListView {
    class ViewModel: ObservableObject {
        
        init(transactions: [TransactionModel]) {
            self.transactions = transactions
            self.filteredTransactions = transactions
        }
        
        private let transactions: [TransactionModel]
        
        @Published var filteredTransactions: [TransactionModel]
        @Published var categoryTotal: Double = ModelData.sampleTransactions.map({ $0.amount }).reduce(0, +)
        
        // MARK: -
        
        var categorySelected: CategoryModel = CategoryModel.all {
            didSet {
                let filteredTransactions = transactions.filter {
                    guard let category = categorySelected.category else { return true }
                    return $0.category.rawValue == category
                }
                self.filteredTransactions = filteredTransactions
                self.categoryTotal = filteredTransactions.map({ $0.amount }).reduce(0, +)
            }
        }

        var categories: [CategoryModel] {
            [CategoryModel.all] +
            TransactionModel.Category.allCases.map({ CategoryModel(category: $0) })
        }
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}
#endif
