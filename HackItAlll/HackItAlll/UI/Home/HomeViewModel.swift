//
//  HomeViewModel.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import Foundation

class HomeViewModel: BaseViewModel {
    @Published var selectedCard: Card
    
    let cards: [Card] = [
        Card(id: 0,
             series: "234567890123456",
             thumbnailUrl: .imgCard1,
             detailsIcon: .imgCard4,
             balance: "2346.70"),
        Card(id: 1,
             series: "9876543210987654",
             thumbnailUrl: .imgCard2,
             detailsIcon: .imgCard5,
             balance: "6700.76"),
        Card(id: 2,
             series: "8765432109876543",
             thumbnailUrl: .imgCard3,
             detailsIcon: .imgCard6,
             balance: "3.00")
    ]
    
    let cardsTransactions: [CardTransaction] = [
        CardTransaction(idCard: 0,
                        transactions: transactionsFirstCard),
        
        CardTransaction(idCard: 1,
                        transactions: transactionsSecondCard),
        
        CardTransaction(idCard: 2,
                        transactions: transactionsThirdCard)
    ]
    
    override init() {
        self.selectedCard = cards.first!
    }
    
    func getTransactionsForCard() -> [Transaction] {
        let result = self.cardsTransactions.first(where: {$0.idCard == self.selectedCard.id})
        if let result = result {
            return result.transactions
        }
        return []
    }
}

let transactionsFirstCard: [Transaction] = [
    Transaction(id: 0,
                amount: "-2354.98",
                name: "Mei Wei"),
    
    Transaction(id: 1,
                amount: "-54364.45",
                name: "Gucci"),
    
    Transaction(id: 2,
                amount: "-3544.45",
                name: "Massimo Dutti"),
    
    Transaction(id: 3,
                amount: "-2354.98",
                name: "Mei Wei"),
    
    Transaction(id: 4,
                amount: "-54364.45",
                name: "Gucci"),
    
    Transaction(id: 5,
                amount: "-3544.45",
                name: "Massimo Dutti"),
    
    Transaction(id: 6,
                amount: "-2354.98",
                name: "Mei Wei"),
    
    Transaction(id: 7,
                amount: "-54364.45",
                name: "Gucci"),
    
    Transaction(id: 8,
                amount: "-3544.45",
                name: "Massimo Dutti"),
    
    Transaction(id: 9,
                amount: "-2354.98",
                name: "Mei Wei"),
    
    Transaction(id: 10,
                amount: "-54364.45",
                name: "Gucci"),
    
    Transaction(id: 11,
                amount: "-3544.45",
                name: "Massimo Dutti"),
    
    Transaction(id: 12,
                amount: "-2354.98",
                name: "Mei Wei"),
    
    Transaction(id: 13,
                amount: "-54364.45",
                name: "Gucci"),
    
    Transaction(id: 14,
                amount: "-3544.45",
                name: "Massimo Dutti"),
    
    Transaction(id: 15,
                amount: "-54364.45",
                name: "Gucci")
]

let transactionsSecondCard: [Transaction] = [
    Transaction(id: 0,
                amount: "-35643.34",
                name: "Balenciaga"),
    
    Transaction(id: 1,
                amount: "-4543.67",
                name: "Mega Image"),
    
    Transaction(id: 2,
                amount: "-23.50",
                name: "5ToGo"),
    
    Transaction(id: 3,
                amount: "-35643.34",
                name: "Balenciaga"),
    
    Transaction(id: 4,
                amount: "-4543.67",
                name: "Mega Image"),
    
    Transaction(id: 5,
                amount: "-23.50",
                name: "5ToGo"),
    
    Transaction(id: 6,
                amount: "-35643.34",
                name: "Balenciaga"),
    
    Transaction(id: 7,
                amount: "-4543.67",
                name: "Mega Image"),
    
    Transaction(id: 8,
                amount: "-23.50",
                name: "5ToGo"),
    
    Transaction(id: 9,
                amount: "-35643.34",
                name: "Balenciaga"),
    
    Transaction(id: 10,
                amount: "-4543.67",
                name: "Mega Image"),
    
    Transaction(id: 11,
                amount: "-23.50",
                name: "5ToGo"),
    
    Transaction(id: 12,
                amount: "-35643.34",
                name: "Balenciaga"),
    
    Transaction(id: 13,
                amount: "-4543.67",
                name: "Mega Image"),
    
    Transaction(id: 14,
                amount: "-23.50",
                name: "5ToGo"),
    
    Transaction(id: 15,
                amount: "-35643.34",
                name: "Balenciaga")
]

let transactionsThirdCard: [Transaction] = [
    Transaction(id: 0,
                amount: "-34645.67",
                name: "Off-White"),
    
    Transaction(id: 1,
                amount: "-435.34",
                name: "Zara"),
    
    Transaction(id: 2,
                amount: "-45234.34",
                name: "Ikea"),
    
    Transaction(id: 3,
                amount: "-34645.67",
                name: "Off-White"),
    
    Transaction(id: 4,
                amount: "-435.34",
                name: "Zara"),
    
    Transaction(id: 5,
                amount: "-45234.34",
                name: "Ikea"),
    
    Transaction(id: 6,
                amount: "-34645.67",
                name: "Off-White"),
    
    Transaction(id: 7,
                amount: "-435.34",
                name: "Zara"),
    
    Transaction(id: 8,
                amount: "-45234.34",
                name: "Ikea"),
    
    Transaction(id: 9,
                amount: "-34645.67",
                name: "Off-White"),
    
    Transaction(id: 10,
                amount: "-435.34",
                name: "Zara"),
    
    Transaction(id: 11,
                amount: "-45234.34",
                name: "Ikea"),
    
    Transaction(id: 12,
                amount: "-34645.67",
                name: "Off-White"),
    
    Transaction(id: 13,
                amount: "-435.34",
                name: "Zara"),
    
    Transaction(id: 14,
                amount: "-45234.34",
                name: "Ikea"),
    
    Transaction(id: 15,
                amount: "-435.34",
                name: "Zara")
]
