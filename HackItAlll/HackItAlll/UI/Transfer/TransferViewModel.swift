//
//  TransferViewModel.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 06.04.2024.
//

import Foundation
import CoreMotion

class TransferVewModel: BaseViewModel {
    let friendsList: [Friend] = [
        Friend(name: "Mirel", phone: "0712 121 121"),
        Friend(name: "Marcel", phone: "0712 121 121"),
        Friend(name: "Dorel", phone: "0712 121 121"),
        Friend(name: "Sorin", phone: "0712 121 121"),
        Friend(name: "Vicentiu", phone: "0712 121 121")
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
