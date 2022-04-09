//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    
    @StateObject private var viewModel = ViewModel()
        
    var body: some View {
        ZStack {
            VStack {
                CategoriesView(categories: viewModel.categories) { viewModel.categorySelected = $0 }
                List {
                    ForEach(viewModel.transactions) { TransactionView(transaction: $0) }
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
        
        @Published var transactions: [TransactionModel] = ModelData.sampleTransactions
        @Published var categoryTotal: Double = ModelData.sampleTransactions.map({ $0.amount }).reduce(0, +)
        
        // MARK: -
        
        var categorySelected: CategoryModel = CategoryModel.all {
            didSet {
                let filteredTransactions = ModelData.sampleTransactions.filter {
                    guard let category = categorySelected.category else { return true }
                    return $0.category.rawValue == category
                }
                transactions = filteredTransactions
                categoryTotal = filteredTransactions.map({ $0.amount }).reduce(0, +)
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
