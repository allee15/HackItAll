//
//  TransactionsViewBiometric.swift
//  HackathonTest
//
//  Created by Bogdan-Gabriel Toma on 03.04.2024.
//

import SwiftUI

struct ExpenseRoundupBiometricView: View {
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
        VStack(spacing: 0) {
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        (viewModel.activeExpenseButton == .back) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(width: 32, height: 32)
                    .overlay {
                        Text((viewModel.activeExpenseButton == .back) ? "T" : "B")
                            .font(.KronaOne.regular(size: 12))
                            .foregroundColor((viewModel.activeExpenseButton == .back) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeExpenseButton == .back {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        printInfo()
                    }
                Spacer()
            }.padding(.bottom, 8)
                .padding(.horizontal, 24)
            
            Rectangle()
                .frame(height: 300)
                .foregroundStyle(Color.bgPrimary)
            
            VStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        (viewModel.activeExpenseButton == .item1) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 72)
                    .overlay {
                        Text((viewModel.activeExpenseButton == .item1) ? "Tap me" : "Button")
                            .font(.KronaOne.regular(size: 12))
                            .foregroundColor((viewModel.activeExpenseButton == .item2) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeExpenseButton == .item1 {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        printInfo()
                    }
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        (viewModel.activeExpenseButton == .item2) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 72)
                    .overlay {
                        Text((viewModel.activeExpenseButton == .item2) ? "Tap me" : "Button")
                            .font(.KronaOne.regular(size: 12))
                            .foregroundColor((viewModel.activeExpenseButton == .item2) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeExpenseButton == .item2 {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        printInfo()
                    }
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        (viewModel.activeExpenseButton == .item3) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 72)
                    .overlay {
                        Text((viewModel.activeExpenseButton == .item3) ? "Tap me" : "Button")
                            .font(.KronaOne.regular(size: 12))
                            .foregroundColor((viewModel.activeExpenseButton == .item3) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeExpenseButton == .item3 {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        printInfo()
                    }
                Spacer(minLength: 80)
            }.padding(.top, 20)
        }.background(Color.bgPrimary)
    }
}
