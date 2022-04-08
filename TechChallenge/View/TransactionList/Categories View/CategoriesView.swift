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
    @State var categories: [CategoryModel]
    var updateFilter: (CategoryModel) -> Void
    
    var body: some View {
        ZStack {
            Color.accentColor.opacity(0.8)
            ScrollView(.horizontal) {
                HStack(spacing: 5) {
                    ForEach(categories, id: \.id) { item in
                        CategoryView(category: item) {
                            self.updateFilter(item)
                        }
                    }
                }.padding()
            }
        }.frame(height: 50)
    }
}
