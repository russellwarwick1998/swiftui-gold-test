//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    @State var filter: String?
    
    private static var allCategory = CategoryModel(category: "all", color: .black)
     
    let transactions: [TransactionModel] = ModelData.sampleTransactions
    let categories: [CategoryModel] =  [TransactionListView.allCategory] +
    TransactionModel.Category.allCases.map({ CategoryModel(category: $0.rawValue, color: $0.color) })
    
    var body: some View {
        VStack {
            ZStack {
                Color.accentColor.opacity(0.8)
                ScrollView(.horizontal) {
                    HStack(spacing: 5) {
                        ForEach(categories, id: \.id) { item in
                            CategoryView(category: item) {
                                self.filter = item.category
                            }
                        }
                    }.padding()
                }
            }.frame(height: 50)
            
            List {
                ForEach(transactions.filter({
                    guard let filter = $filter.wrappedValue, filter != TransactionListView.allCategory.category else { return true }
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
