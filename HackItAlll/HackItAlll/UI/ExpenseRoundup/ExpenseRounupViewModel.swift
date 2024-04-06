//
//  ExpenseRounupViewModel.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 07.04.2024.
//

import Foundation
import SwiftUI
import CoreMotion

class ExpenseRoundupViewModel: BaseViewModel {
    let expensesRoundupFirst: [ExpenseRoundup] = [
        ExpenseRoundup(id: 0,
                       item: "Food",
                       amount: 1774.9,
                       color: Color(hex: "#FFD7FB"),
                       percentage: 12),
        ExpenseRoundup(id: 1,
                       item: "Fashion",
                       amount: 343908.95,
                       color: Color(hex: "#D7F3FF"),
                       percentage: Int((343908.95 / 389031.94) * 100)),
    ]
    
    let expensesRoundupSecond: [ExpenseRoundup] = [
        ExpenseRoundup(id: 0,
                       item: "Food",
                       amount: 22718.35,
                       color: Color(hex: "#FFD7FB"),
                       percentage: 16),
        ExpenseRoundup(id: 1,
                       item: "Fashion",
                       amount: 213860.04,
                       color: Color(hex: "#D7F3FF"),
                       percentage: 75),
        ExpenseRoundup(id: 2,
                       item: "Others",
                       amount: 117.5,
                       color: Color(hex: "#E6D7FF"),
                       percentage: 9)
    ]
    
    let expensesRoundupThird: [ExpenseRoundup] = [
        ExpenseRoundup(id: 0,
                       item: "Fashion",
                       amount: 175840.39,
                       color: Color(hex: "#FFD7FB"),
                       percentage: Int((175840.39 / 402012.09) * 100)),
        ExpenseRoundup(id: 1,
                       item: "Others",
                       amount: 226171.7,
                       color: Color(hex: "#D7F3FF"),
                       percentage: Int((226171.7 / 402012.09) * 100))
    ]
    
    let totals: [Double] = [389031.94, 236695.89, 402012.09]
    
    @Published var rollDegrees = 0.0
    @Published var pitchDegrees = 0.0
    @Published var globalFrame: CGRect = .zero
    @Published var globalTap: CGPoint = .zero
    
    let motionManager = CMMotionManager()
    var data: [Float] = []
    
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
    
    func printInfo() {
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
    }
}
