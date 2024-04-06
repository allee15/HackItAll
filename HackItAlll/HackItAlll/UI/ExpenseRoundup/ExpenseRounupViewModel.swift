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
                       color: Color(hex: "#DBB8D7"),
                       percentage: 12),
        ExpenseRoundup(id: 1,
                       item: "Fashion",
                       amount: 343908.95,
                       color: Color(hex: "#C2DEEA"),
                       percentage: 88)
    ]
    
    let expensesRoundupSecond: [ExpenseRoundup] = [
        ExpenseRoundup(id: 0,
                       item: "Food",
                       amount: 22718.35,
                       color: Color(hex: "#DBB8D7"),
                       percentage: 16),
        ExpenseRoundup(id: 1,
                       item: "Fashion",
                       amount: 213860.04,
                       color: Color(hex: "#C2DEEA"),
                       percentage: 75),
        ExpenseRoundup(id: 2,
                       item: "Others",
                       amount: 117.5,
                       color: Color(hex: "#C2B5D8"),
                       percentage: 9)
    ]
    
    let expensesRoundupThird: [ExpenseRoundup] = [
        ExpenseRoundup(id: 0,
                       item: "Fashion",
                       amount: 175840.39,
                       color: Color(hex: "#DBB8D7"),
                       percentage: 44),
        ExpenseRoundup(id: 1,
                       item: "Others",
                       amount: 226171.7,
                       color: Color(hex: "#C2DEEA"),
                       percentage: 56)
    ]
    
    @Published var rollDegrees = 0.0
    @Published var pitchDegrees = 0.0
    @Published var globalFrame: CGRect = .zero
    @Published var globalTap: CGPoint = .zero
    
    let motionManager = CMMotionManager()
    var data: [Float] = []
    var response: Bool = false
    
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
