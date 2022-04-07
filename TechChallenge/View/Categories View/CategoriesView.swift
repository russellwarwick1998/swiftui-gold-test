//
//  CategoriesView.swift
//  TechChallenge
//
//  Created by Russell Warwick on 07/04/2022.
//

import SwiftUI

struct CategoryModel: Identifiable {
    let id = UUID()
    let category: String
    let color: Color
}

struct CategoriesView: View {
    
    var updateFilter: (String?) -> Void
    let categories: [CategoryModel] = [CategoryModel(category: "all", color: .black)] +
    TransactionModel.Category.allCases.map({ CategoryModel(category: $0.rawValue, color: $0.color) })
    
    var body: some View {
        ZStack {
            Color.accentColor.opacity(0.8)
            ScrollView(.horizontal) {
                HStack(spacing: 5) {
                    ForEach(categories, id: \.id) { item in
                        CategoryView(category: item) {
                            self.updateFilter((item.category == "all") ? nil : item.category)
                        }
                    }
                }.padding()
            }
        }.frame(height: 50)
    }
}
