//
//  TransactionsViewBiometric.swift
//  HackathonTest
//
//  Created by Bogdan-Gabriel Toma on 03.04.2024.
//

import SwiftUI

struct TransactionBiometricsView: View {
    
    @ObservedObject var viewModel: BiometricViewModel
    
    @State private var globalFrame: CGRect = .zero
    @State private var globalTap: CGPoint = .zero
    
    private func printInfo() {
        let startX = globalFrame.minX
        let startY = globalFrame.minY
        let endX = globalFrame.maxX
        let endY = globalFrame.maxY
        let tapX = globalTap.x
        let tapY = globalTap.y
        
        print("Starting Coordinates: (\(startX), \(startY))")
        print("Ending Coordinates: (\(endX), \(endY))")
        print("Tap Coordinates: (\(tapX), \(tapY))")
        print("Roll Degrees: \(viewModel.rollDegrees)")
        print("Pitch Degrees: \(viewModel.pitchDegrees)")
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.bgPrimary)
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            (viewModel.activeTransactionsButton == .MoreTransaction1) ?
                            Color.bgSecondary :
                                Color.bgSecondary.opacity(0.32)
                        )
                        .frame(height: 50)
                    
                    Text((viewModel.activeTransactionsButton == .MoreTransaction1) ? "Tap me now" : "Just a simple button")
                        .foregroundColor((viewModel.activeTransactionsButton == .MoreTransaction1) ? .black : .white)
                }
                .modifier(GlobalPositionModifier())
                .onPreferenceChange(GlobalFrameKey.self) { value in
                    self.globalFrame = value
                }
                .onTapGesture(coordinateSpace: .global) { location in
                    self.globalTap = location
                    
                    if viewModel.activeTransactionsButton == .MoreTransaction1 {
                        viewModel.taps += 1
                        print(viewModel.taps)
                        viewModel.restartTimer()
                    }
                    
//                    printInfo()
                }
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            (viewModel.activeTransactionsButton == .MoreTransaction2) ?
                            Color.bgSecondary :
                                Color.bgSecondary.opacity(0.32)
                        )
                        .frame(height: 50)
                    
                    Text((viewModel.activeTransactionsButton == .MoreTransaction2) ? "Tap me now" : "Just a simple button")
                        .foregroundColor((viewModel.activeTransactionsButton == .MoreTransaction2) ? .black : .white)
                }
                .modifier(GlobalPositionModifier())
                .onPreferenceChange(GlobalFrameKey.self) { value in
                    self.globalFrame = value
                }
                .onTapGesture(coordinateSpace: .global) { location in
                    self.globalTap = location
                    
                    if viewModel.activeTransactionsButton == .MoreTransaction2 {
                        viewModel.taps += 1
                        print(viewModel.taps)
                        viewModel.restartTimer()
                    }
                    
//                    printInfo()
                }
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            (viewModel.activeTransactionsButton == .MoreTransaction3) ?
                            Color.bgSecondary :
                                Color.bgSecondary.opacity(0.32)
                        )
                        .frame(height: 50)
                    
                    Text((viewModel.activeTransactionsButton == .MoreTransaction3) ? "Tap me now" : "Just a simple button")
                        .foregroundColor((viewModel.activeTransactionsButton == .MoreTransaction3) ? .black : .white)
                }
                .modifier(GlobalPositionModifier())
                .onPreferenceChange(GlobalFrameKey.self) { value in
                    self.globalFrame = value
                }
                .onTapGesture(coordinateSpace: .global) { location in
                    self.globalTap = location
                    
                    if viewModel.activeTransactionsButton == .MoreTransaction3 {
                        viewModel.taps += 1
                        print(viewModel.taps)
                        viewModel.restartTimer()
                    }
                    
//                    printInfo()
                }
                
                Spacer()
            }
            .padding(20)
        }
    }
}
