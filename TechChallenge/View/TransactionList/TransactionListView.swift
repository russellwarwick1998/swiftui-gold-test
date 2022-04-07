//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    @State var filter: String?
    
    let transactions: [TransactionModel] = ModelData.sampleTransactions
    
    var body: some View {
        VStack {
            
            CategoriesView { filter in
                self.filter = filter
            }
            
            List {
                ForEach(transactions.filter({
                    guard let filter = $filter.wrappedValue else { return true }
                    return $0.category.rawValue == filter
                })) { transaction in
                    TransactionView(transaction: transaction)
                }
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Transactions")
            
      
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
