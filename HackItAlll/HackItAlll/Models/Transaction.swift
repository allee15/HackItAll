//
//  Transactions.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import Foundation
import SwiftUI

struct Transaction: Identifiable {
    let id: Int
    let amount: String
    let name: String
}

struct CardTransaction {
    let idCard: Int
    let transactions: [Transaction]
}

struct ExpenseRoundup {
    let id: Int
    let item: String
    let amount: Double
    let color: Color
    let percentage: Int
}

