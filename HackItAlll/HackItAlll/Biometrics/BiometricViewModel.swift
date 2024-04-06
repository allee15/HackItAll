//
//  BiometricViewModel.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import Foundation
import CoreMotion

enum HomeButtons: CaseIterable {
    case None
    case Balance
    case Transaction1
    case Transaction2
    case Transaction3
    case More
}

enum PaymentButtons: CaseIterable {
    case None
    case Iban
    case Amount
    case Currency
    case Message
    case ScheduledDate
    case Pay
}

enum TransactionsButton: CaseIterable {
    case None
    case MoreTransaction1
    case MoreTransaction2
    case MoreTransaction3
}

class BiometricViewModel: BaseViewModel {
    @Published var taps = 0
    
    @Published var activeHomeButton: HomeButtons = .None
    @Published var activePaymentButton: PaymentButtons = .None
    @Published var activeTransactionsButton: TransactionsButton = .None
    
    @Published var rollDegrees = 0.0
    @Published var pitchDegrees = 0.0
    
    var timer = Timer()
    
    var data: [Float] = []
    
    let motionManager = CMMotionManager()
    
    override init() {
        super.init()
        self.startTimer()
        self.startAccelerometerData()
    }
    
    deinit {
        self.timer.invalidate()
    }
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateActiveButtons()
        }
    }
    
    func restartTimer() {
        self.timer.invalidate()
        self.updateActiveButtons()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateActiveButtons()
        }
    }
    
    func updateActiveButtons() {
        let pastHomeValue = self.activeHomeButton
        while pastHomeValue == self.activeHomeButton || self.activeHomeButton == .None {
            self.activeHomeButton = HomeButtons.allCases.randomElement() ?? .None
        }
        
        let pastPaymentValue = self.activePaymentButton
        while pastPaymentValue == self.activePaymentButton || self.activePaymentButton == .None {
            self.activePaymentButton = PaymentButtons.allCases.randomElement() ?? .None
        }
        
        let pastTransactionsValue = self.activeTransactionsButton
        while pastTransactionsValue == self.activeTransactionsButton || self.activeTransactionsButton == .None {
            self.activeTransactionsButton = TransactionsButton.allCases.randomElement() ?? .None
        }
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
}
