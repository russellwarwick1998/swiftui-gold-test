//
//  CategoriesView.swift
//  TechChallenge
//
//  Created by Russell Warwick on 07/04/2022.
//

import SwiftUI

struct CategoryModel: Identifiable {
    
    init(title: String, color: Color) {
        self.title = title
        self.category = nil
        self.color = color
    }
    
    init(category: TransactionModel.Category) {
        self.title = category.rawValue
        self.category = category.rawValue
        self.color = category.color
    }
    
    static var all = CategoryModel(title: "all", color: .black)
    
    let id = UUID()
    let title: String
    let category: String?
    let color: Color
}

struct CategoryView: View {
    let category: CategoryModel
    var didTap: () -> Void
    
    var body: some View {
        Button(action: {
            self.didTap()
        }, label: {
            Text(category.title)
            .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
            .foregroundColor(.white)
            .font(Font.title2.weight(.bold))
            .background(category.color)
            .clipShape(Capsule())
        })
    }
}

struct CategoriesView: View {
    
    var categories: [CategoryModel]
    var setSelectedCategory: (CategoryModel) -> Void
    
    // MARK: -
    
    var body: some View {
        ZStack {
            Color.accentColor.opacity(0.8)
            ScrollView(.horizontal) {
                HStack(spacing: 5) {
                    ForEach(categories, id: \.id) { category in
                        CategoryView(category: category) {
                            self.setSelectedCategory(category)
                        }
                    }
                }.padding()
            }
        }.frame(height: 50)
    }
}
