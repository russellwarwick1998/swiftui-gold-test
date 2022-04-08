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
                CategoriesView(categories: viewModel.categories) { filter in
                    viewModel.filter = filter
                }
                
                List {
                    ForEach(viewModel.transactions) { transaction in
                        TransactionView(transaction: transaction)
                    }
                    Spacer(minLength: 100)
                }
                .animation(.easeIn)
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Transactions")
            }
        }
    }
}

extension TransactionListView {
    class ViewModel: ObservableObject {
        
        @Published var transactions: [TransactionModel] = ModelData.sampleTransactions
        @Published var filter: String? = nil {
            didSet {
                transactions = ModelData.sampleTransactions.filter {
                    guard let filter = filter else { return true }
                    return $0.category.rawValue == filter
                }
            }
        }
        
        var categories: [CategoryModel] {
            [CategoryModel(category: "all", color: .black)] +
            TransactionModel.Category.allCases.map({ CategoryModel(category: $0.rawValue, color: $0.color) })
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
