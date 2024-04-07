//
//  HomeViewModel.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import Foundation
import CoreMotion

class HomeViewModel: BaseViewModel {
    @Published var selectedCard: Card
    
    @Published var rollDegrees = 0.0
    @Published var pitchDegrees = 0.0
    
    @Published var globalFrame: CGRect = .zero
    @Published var globalTap: CGPoint = .zero
    
    let motionManager = CMMotionManager()
    var data: [Float] = []
    var response: String = ""
    
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
    
    func startAccelerometerData() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                if let accelerometerData = data {
                    let acceleration = accelerometerData.acceleration
                    
                    let rollRadians = atan2(acceleration.y, acceleration.z)
                    self.rollDegrees = rollRadians * 180 / .pi
                    
                    let pitchRadians = atan2(-acceleration.x, sqrt(acceleration.y * acceleration.y + acceleration.z * acceleration.z))
                    self.pitchDegrees = pitchRadians * 180 / .pi
                }
            }
        }
    }
    
    func addData(xStart: Float, yStart: Float, xEnd: Float, yEnd: Float, xTap: Float, yTap: Float, xRot: Float, yRot: Float, zRot: Float) {
        data.append(xStart)
        data.append(yStart)
        data.append(xEnd)
        data.append(yEnd)
        data.append(xTap)
        data.append(yTap)
        data.append(xRot)
        data.append(yRot)
        data.append(zRot)
    }
    
    func printInfo(location: CGPoint) {
        self.globalTap = location
        let startX = globalFrame.minX
        let startY = globalFrame.minY
        let endX = globalFrame.maxX
        let endY = globalFrame.maxY
        let tapX = globalTap.x
        let tapY = globalTap.y
        
        print("Starting Coordinates: (\(startX), \(startY))")
        print("Ending Coordinates: (\(endX), \(endY))")
        print("Tap Coordinates: (\(tapX), \(tapY))")
        print("Roll Degrees: \(rollDegrees)")
        print("Pitch Degrees: \(pitchDegrees)")
        
        TapService.shared.postTapOnce(xStart: Float(startX), yStart: Float(startY), xEnd: Float(endX), yEnd: Float(endY), x: Float(tapX), y: Float(tapY), roll: Float(rollDegrees), pitch: Float(pitchDegrees))
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] result in
                self?.response = result
            }.store(in: &bag)
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
