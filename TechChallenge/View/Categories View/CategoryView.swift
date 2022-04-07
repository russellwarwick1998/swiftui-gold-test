//
//  CategoriesView.swift
//  TechChallenge
//
//  Created by Russell Warwick on 07/04/2022.
//

import SwiftUI

struct CategoryView: View {
    let category: CategoryModel
    var didTap: () -> Void
    
    var body: some View {
        Button(action: {
            self.didTap()
        }, label: {
            Text(category.category)
            .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
            .foregroundColor(.white)
            .font(Font.title2.weight(.bold))
            .background(category.color)
            .clipShape(Capsule())
        })
    }
}
