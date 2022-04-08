//
//  FloatingView.swift
//  TechChallenge
//
//  Created by Russell Warwick on 08/04/2022.
//

import SwiftUI

struct FloatingView: View {
    
    let total: Double
    let category: CategoryModel
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                HStack {
                    Spacer()
                    Text(category.category)
                        .font(.headline)
                        .foregroundColor(category.color)
                }
                HStack() {
                    Text("Total spent:")
                        
                    Spacer()
                    Text(total, format: .currency(code: "USD"))
                        .fontWeight(.bold)
                }
            }.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.accentColor, lineWidth: 2)
            )
        }.padding()
    }
}
