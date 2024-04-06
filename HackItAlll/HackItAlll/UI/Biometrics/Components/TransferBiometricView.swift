//
//  BiometricsScreen.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import SwiftUI

struct TransferBiometricView: View {
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
        VStack(spacing: 0){
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        (viewModel.activeTransferButton == .back) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(width: 32, height: 32)
                    .overlay {
                        Text((viewModel.activeTransferButton == .back) ? "T" : "B")
                            .font(.KronaOne.regular(size: 12))
                            .foregroundColor((viewModel.activeTransferButton == .back) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeTransferButton == .back {
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
                .frame(height: 200)
                .foregroundStyle(Color.bgPrimary)
            
            VStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        (viewModel.activeTransferButton == .friend1) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 72)
                    .overlay {
                        Text((viewModel.activeTransferButton == .friend1) ? "Tap me" : "Button")
                            .font(.KronaOne.regular(size: 12))
                            .foregroundColor((viewModel.activeTransferButton == .friend1) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeTransferButton == .friend1 {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        printInfo()
                    }
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        (viewModel.activeTransferButton == .friend2) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 72)
                    .overlay {
                        Text((viewModel.activeTransferButton == .friend2) ? "Tap me" : "Button")
                            .font(.KronaOne.regular(size: 12))
                            .foregroundColor((viewModel.activeTransferButton == .friend2) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeTransferButton == .friend2 {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        printInfo()
                    }
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        (viewModel.activeTransferButton == .friend3) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 72)
                    .overlay {
                        Text((viewModel.activeTransferButton == .friend3) ? "Tap me" : "Button")
                            .font(.KronaOne.regular(size: 12))
                            .foregroundColor((viewModel.activeTransferButton == .friend3) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeTransferButton == .friend3 {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        printInfo()
                    }
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        (viewModel.activeTransferButton == .friend4) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 72)
                    .overlay {
                        Text((viewModel.activeTransferButton == .friend4) ? "Tap me" : "Button")
                            .font(.KronaOne.regular(size: 12))
                            .foregroundColor((viewModel.activeTransferButton == .friend4) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeTransferButton == .friend4 {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        printInfo()
                    }
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        (viewModel.activeTransferButton == .friend5) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 72)
                    .overlay {
                        Text((viewModel.activeTransferButton == .friend5) ? "Tap me" : "Button")
                            .font(.KronaOne.regular(size: 12))
                            .foregroundColor((viewModel.activeTransferButton == .friend5) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeTransferButton == .friend5 {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        printInfo()
                    }
                Spacer(minLength: 80)
            }.padding(.horizontal, 24)
            
        }.background(Color.bgPrimary)
    }
}


