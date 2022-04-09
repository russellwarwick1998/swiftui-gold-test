//
//  TechChallengeApp.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

@main
struct TechChallengeApp: App {

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    VStack {
                        TransactionListView()
                    }
                }
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
                
                NavigationView {
                    InsightsView(viewModel: InsightsView.ViewModel(transactions: ModelData.sampleTransactions))
                }
                .tabItem {
                    Label("Insights", systemImage: "chart.pie.fill")
                }
            }
        }
    }
}
