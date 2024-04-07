//
//  BiometricViewModel.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import Foundation
import CoreMotion
import Combine

enum HomeButtons: CaseIterable {
    case none
    case account
    case cards
    case details
    case button1
    case button2
    case button3
    case tranzactions
}

enum PaymentButtons: CaseIterable {
    case none
    case back
    case friend1
    case friend2
    case friend3
    case friend4
    case friend5
}

enum TransactionsButton: CaseIterable {
    case none
    case back
    case item1
    case item2
    case item3
}

enum TapSendingCompletion {
    case completed
    case loading
    case failure(Error)
}

class BiometricViewModel: BaseViewModel {
    @Published var taps = 0
    
    @Published var activeHomeButton: HomeButtons = .none
    @Published var activeTransferButton: PaymentButtons = .none
    @Published var activeExpenseButton: TransactionsButton = .none
    
    @Published var rollDegrees = 0.0
    @Published var pitchDegrees = 0.0
    
    let eventSubject = PassthroughSubject<TapSendingCompletion, Never>()
    
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
        while pastHomeValue == self.activeHomeButton || self.activeHomeButton == .none {
            self.activeHomeButton = HomeButtons.allCases.randomElement() ?? .none
        }
        
        let pastTransferButton = self.activeTransferButton
        while pastTransferButton == self.activeTransferButton || self.activeTransferButton == .none {
            self.activeTransferButton = PaymentButtons.allCases.randomElement() ?? .none
        }
        
        let pastTransactionsValue = self.activeExpenseButton
        while pastTransactionsValue == self.activeExpenseButton || self.activeExpenseButton == .none {
            self.activeExpenseButton = TransactionsButton.allCases.randomElement() ?? .none
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
    
    func postAllTaps() {
        eventSubject.send(.loading)
        
        TapService.shared.postAllTaps()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.eventSubject.send(.completed)
                case .failure(let error):
                    self.eventSubject.send(.failure(error))
                }
            } receiveValue: { [weak self] result in
                self?.eventSubject.send(.completed)
            }.store(in: &bag)
    }
}
