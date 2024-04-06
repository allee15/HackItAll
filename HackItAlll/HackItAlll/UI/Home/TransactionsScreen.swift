//
//  TransactionsScreen.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import SwiftUI

struct TransactionsScreen: View {
    @EnvironmentObject private var navigation: Navigation
    let transactions: [Transaction]
    let months: [String] = ["April", "March", "February", "January", "December"]
    
    var body: some View {
        VStack(spacing: 0) {
            BackButton(text: "Transactions") {
                navigation.pop(animated: true)
            }.padding(.bottom, 16)
            .padding(.horizontal, 24)
            
            ScrollView(showsIndicators: false) {
                ForEach(0..<5) { groupIndex in
                    MonthView(monthName: months[groupIndex])
                        .padding(.bottom, 16)
                    
                    VStack(spacing: 16) {
                        ForEach(0..<3) { elementIndex in
                            let arrayIndex = groupIndex * 3 + elementIndex
                            TransactionWidgetView(transaction: transactions[arrayIndex])
                                .padding(.horizontal, 16)
                        }
                    }.padding(.bottom, 16)
                }
            }
        }.background(Color.bgPrimary)
    }
}

struct MonthView: View {
    let monthName: String
    
    var body: some View {
        HStack {
            Text(monthName)
                .font(.KronaOne.regular(size: 16))
                .foregroundStyle(Color.white)
            
            Spacer()
        }.padding(.horizontal, 24)
            .background(Color.bgSecondary.opacity(0.32))
    }
}
