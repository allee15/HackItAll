//
//  Transactions.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import Foundation

struct Transaction: Identifiable {
    let id: Int
    let amount: String
    let name: String
}

struct CardTransaction {
    let idCard: Int
    let transactions: [Transaction]
}
