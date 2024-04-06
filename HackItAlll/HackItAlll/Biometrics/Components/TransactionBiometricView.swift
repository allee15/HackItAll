//
//  TransactionsViewBiometric.swift
//  HackathonTest
//
//  Created by Bogdan-Gabriel Toma on 03.04.2024.
//

import SwiftUI

struct TransactionBiometricsView: View {
    
    @StateObject var viewModel = BiometricViewModel()
    
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
                .fill(.white)
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            (viewModel.activeTransactionsButton == .MoreTransaction1) ?
                                .blue :
                                    .gray
                        )
                        .frame(height: 50)
                    
                    Text("Transaction 1")
                        .foregroundColor(.white)
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
                                .blue :
                                    .gray
                        )
                        .frame(height: 50)
                    
                    Text("Transaction 2")
                        .foregroundColor(.white)
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
                                .blue :
                                    .gray
                        )
                        .frame(height: 50)
                    
                    Text("Transaction 3")
                        .foregroundColor(.white)
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
