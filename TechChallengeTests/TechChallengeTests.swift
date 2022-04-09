//
//  TechChallengeTests.swift
//  TechChallengeTests
//
//  Created by Adrian Tineo Cabello on 30/7/21.
//

import XCTest
@testable import TechChallenge

class TechChallengeTests: XCTestCase {
    
    func test_filteredCategories_whenAll_returnAllTransactions() {
        let sut = TransactionListView.ViewModel(transactions: ModelData.sampleTransactions)
        sut.categorySelected = .all
        let allCategories = TransactionModel.Category.allCases.map({ $0.rawValue })
        XCTAssert(sut.filteredTransactions.contains(where: { allCategories.contains($0.category.rawValue) }))
    }

    func test_filteredCategories_whenEntertainment_returnOnlyEntertainmentTransactions() {
        let sut = TransactionListView.ViewModel(transactions: ModelData.sampleTransactions)
        sut.categorySelected = CategoryModel(category: .entertainment)
        XCTAssert(sut.filteredTransactions.contains(where: { $0.category.rawValue == "entertainment" }))
    }
    
    func test_filteredCategories_whenEntertainment_shouldNotContainFood() {
        let sut = TransactionListView.ViewModel(transactions: ModelData.sampleTransactions)
        sut.categorySelected = CategoryModel(category: .entertainment)
        XCTAssertFalse(sut.filteredTransactions.contains(where: { $0.category.rawValue == "food" }))
    }
    
    func test_totalAmount_whenAllSelected_showCorrectAmount() {
        let sut = TransactionListView.ViewModel(transactions: ModelData.sampleTransactions)
        sut.categorySelected = .all
        XCTAssertEqual(sut.categoryTotal, 472.08, accuracy: 0.01)
    }
    
    func test_totalAmount_whenFoodSelected_showCorrectAmount() {
        let sut = TransactionListView.ViewModel(transactions: ModelData.sampleTransactions)
        sut.categorySelected = CategoryModel(category: .food)
        XCTAssertEqual(sut.categoryTotal, 74.28, accuracy: 0.01)
    }
    
    func test_totalAmount_whenEntertainmentNotPresent_showZero() {
        let transactions = ModelData.sampleTransactions.filter({ $0.category.rawValue != "entertainment" })
        let sut = TransactionListView.ViewModel(transactions: transactions)
        sut.categorySelected = CategoryModel(category: .entertainment)
        XCTAssertEqual(sut.categoryTotal, 0.0, accuracy: 0.01)
    }
    
    func test_totalAmount_whenNoData_showZero() {
        let sut = TransactionListView.ViewModel(transactions: [])
        sut.categorySelected = .all
        XCTAssertEqual(sut.categoryTotal, 0.0, accuracy: 0.01)
    }
}
