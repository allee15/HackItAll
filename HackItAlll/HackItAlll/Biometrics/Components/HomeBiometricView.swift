//
//  HomeViewBiometric.swift
//  HackathonTest
//
//  Created by Bogdan-Gabriel Toma on 03.04.2024.
//

import SwiftUI
import CoreMotion

struct HomeBiometricsView: View {
    
    @ObservedObject var viewModel: BiometricViewModel
    
    @State private var globalFrame: CGRect = .zero
    @State private var globalTap: CGPoint = .zero
    
    private var cardSize: CGSize {
        let scaleFactor: CGFloat = 2
        let width = UIScreen.main.bounds.width / scaleFactor
        let aspectRatio = 1.5
        let height = width * aspectRatio
        return .init(width: width, height: height)
    }
    
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
        VStack {
            
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        (viewModel.activeHomeButton == .account) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(width: 24, height: 24)
                    .overlay {
                        Text((viewModel.activeHomeButton == .account) ? "T" : "B")
                            .font(.KronaOne.regular(size: 12))
                            .foregroundColor((viewModel.activeHomeButton == .account) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeHomeButton == .account {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        //                printInfo()
                    }
                
                Spacer()
            }.padding(.top, 12)
            
            Spacer(minLength: 48)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    (viewModel.activeHomeButton == .cards) ?
                    Color.bgSecondary :
                        Color.bgSecondary.opacity(0.32)
                )
                .frame(width: cardSize.width, height: cardSize.height)
                .overlay {
                    Text((viewModel.activeHomeButton == .cards) ? "Tap me" : "Button")
                        .font(.KronaOne.regular(size: 16))
                        .foregroundColor((viewModel.activeHomeButton == .cards) ? .black : .white)
                }
                .modifier(GlobalPositionModifier())
                .onPreferenceChange(GlobalFrameKey.self) { value in
                    self.globalFrame = value
                }
                .onTapGesture(coordinateSpace: .global) { location in
                    self.globalTap = location
                    
                    if viewModel.activeHomeButton == .cards {
                        viewModel.taps += 1
                        print(viewModel.taps)
                        viewModel.restartTimer()
                    }
                    //                printInfo()
                }
            
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        (viewModel.activeHomeButton == .details) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(width: 135, height: 16)
                    .overlay {
                        Text((viewModel.activeHomeButton == .details) ? "Tap me" : "Button")
                            .font(.KronaOne.regular(size: 10))
                            .foregroundColor((viewModel.activeHomeButton == .details) ? .black : .white)
                    }
                    .padding(.top, 8)
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeHomeButton == .details {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        //                printInfo()
                    }
            
            Spacer(minLength: 56)
            
            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        (viewModel.activeHomeButton == .button1) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(width: 104, height: 40)
                    .overlay {
                        Text((viewModel.activeHomeButton == .button1) ? "Tap me" : "Button")
                            .font(.KronaOne.regular(size: 10))
                            .foregroundColor((viewModel.activeHomeButton == .button1) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeHomeButton == .button1 {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        //                printInfo()
                    }
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        (viewModel.activeHomeButton == .button2) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(width: 104, height: 40)
                    .overlay {
                        Text((viewModel.activeHomeButton == .button2) ? "Tap me" : "Button")
                            .font(.KronaOne.regular(size: 10))
                            .foregroundColor((viewModel.activeHomeButton == .button2) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeHomeButton == .button2 {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        //                printInfo()
                    }
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        (viewModel.activeHomeButton == .button3) ?
                        Color.bgSecondary :
                            Color.bgSecondary.opacity(0.32)
                    )
                    .frame(width: 104, height: 40)
                    .overlay {
                        Text((viewModel.activeHomeButton == .button3) ? "Tap me" : "Button")
                            .font(.KronaOne.regular(size: 10))
                            .foregroundColor((viewModel.activeHomeButton == .button3) ? .black : .white)
                    }
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        self.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        self.globalTap = location
                        
                        if viewModel.activeHomeButton == .button3 {
                            viewModel.taps += 1
                            print(viewModel.taps)
                            viewModel.restartTimer()
                        }
                        //                printInfo()
                    }
            }.padding(.bottom, 16)
            
            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            (viewModel.activeHomeButton == .tranzactions) ?
                            Color.bgSecondary :
                                Color.bgSecondary.opacity(0.32)
                        )
                        .frame(width: 104, height: 40)
                        .overlay {
                            Text((viewModel.activeHomeButton == .tranzactions) ? "Tap me" : "Button")
                                .font(.KronaOne.regular(size: 12))
                                .foregroundColor((viewModel.activeHomeButton == .tranzactions) ? .black : .white)
                        }
                        .modifier(GlobalPositionModifier())
                        .onPreferenceChange(GlobalFrameKey.self) { value in
                            self.globalFrame = value
                        }
                        .onTapGesture(coordinateSpace: .global) { location in
                            self.globalTap = location
                            
                            if viewModel.activeHomeButton == .tranzactions {
                                viewModel.taps += 1
                                print(viewModel.taps)
                                viewModel.restartTimer()
                            }
                            //                printInfo()
                        }
                }
                
                Spacer()
            }.padding(.vertical, 16)
        }.padding(.horizontal, 16)
    }
}
