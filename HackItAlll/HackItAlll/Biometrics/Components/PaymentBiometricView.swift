//
//  BiometricsScreen.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import SwiftUI

struct PaymentBiometricsView: View {
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
           VStack {
               ZStack {
                   RoundedRectangle(cornerRadius: 20)
                       .fill(
                           (viewModel.activePaymentButton == .Iban) ?
                           Color.bgSecondary :
                               Color.bgSecondary.opacity(0.32)
                       )
                       .frame(height: 50)
                   
                   Text((viewModel.activePaymentButton == .Iban) ? "Tap me now" : "Just a simple button")
                       .foregroundColor((viewModel.activePaymentButton == .Iban) ? .black : .white)
               }
               .modifier(GlobalPositionModifier())
               .onPreferenceChange(GlobalFrameKey.self) { value in
                   self.globalFrame = value
               }
               .onTapGesture(coordinateSpace: .global) { location in
                   self.globalTap = location
                   
                   if viewModel.activePaymentButton == .Iban {
                       viewModel.taps += 1
                       print(viewModel.taps)
                       viewModel.restartTimer()
                   }
                   
   //                printInfo()
               }
               
               Spacer()
               
               HStack {
                   
                   ZStack {
                       RoundedRectangle(cornerRadius: 20)
                           .fill(
                               (viewModel.activePaymentButton == .Amount) ?
                               Color.bgSecondary :
                                   Color.bgSecondary.opacity(0.32)
                           )
                           .frame(height: 50)
                       
                       Text((viewModel.activePaymentButton == .Amount) ? "Tap me now" : "Just a simple button")
                           .foregroundColor((viewModel.activePaymentButton == .Amount) ? .black : .white)
                   }
                   .modifier(GlobalPositionModifier())
                   .onPreferenceChange(GlobalFrameKey.self) { value in
                       self.globalFrame = value
                   }
                   .onTapGesture(coordinateSpace: .global) { location in
                       self.globalTap = location
                       
                       if viewModel.activePaymentButton == .Amount {
                           viewModel.taps += 1
                           print(viewModel.taps)
                           viewModel.restartTimer()
                       }
                       
   //                    printInfo()
                   }
                   
                   Spacer()
                   
                   
                   ZStack {
                       RoundedRectangle(cornerRadius: 20)
                           .fill(
                               (viewModel.activePaymentButton == .Currency) ?
                               Color.bgSecondary :
                                   Color.bgSecondary.opacity(0.32)
                           )
                           .frame(height: 50)
                       
                       Text((viewModel.activePaymentButton == .Currency) ? "Tap me now" : "Just a simple button")
                           .foregroundColor((viewModel.activePaymentButton == .Currency) ? .black : .white)
                   }
                   .modifier(GlobalPositionModifier())
                   .onPreferenceChange(GlobalFrameKey.self) { value in
                       self.globalFrame = value
                   }
                   .onTapGesture(coordinateSpace: .global) { location in
                       self.globalTap = location
                       
                       if viewModel.activePaymentButton == .Currency {
                           viewModel.taps += 1
                           print(viewModel.taps)
                           viewModel.restartTimer()
                       }
                       
   //                    printInfo()
                   }
               }
               
               Spacer()
               
               
               ZStack {
                   RoundedRectangle(cornerRadius: 20)
                       .fill(
                           (viewModel.activePaymentButton == .Message) ?
                           Color.bgSecondary :
                               Color.bgSecondary.opacity(0.32)
                       )
                       .frame(height: 100)
                   
                   Text((viewModel.activePaymentButton == .Message) ? "Tap me now" : "Just a simple button")
                       .foregroundColor((viewModel.activePaymentButton == .Message) ? .black : .white)
               }
               .modifier(GlobalPositionModifier())
               .onPreferenceChange(GlobalFrameKey.self) { value in
                   self.globalFrame = value
               }
               .onTapGesture(coordinateSpace: .global) { location in
                   self.globalTap = location
                   
                   if viewModel.activePaymentButton == .Message {
                       viewModel.taps += 1
                       print(viewModel.taps)
                       viewModel.restartTimer()
                   }
                   
   //                printInfo()
               }
           }
           
           Spacer()
           
           
           ZStack {
               RoundedRectangle(cornerRadius: 20)
                   .fill(
                       (viewModel.activePaymentButton == .ScheduledDate) ?
                       Color.bgSecondary :
                           Color.bgSecondary.opacity(0.32)
                   )
                   .frame(height: 50)
               
               Text((viewModel.activePaymentButton == .ScheduledDate) ? "Tap me now" : "Just a simple button")
                   .foregroundColor((viewModel.activePaymentButton == .ScheduledDate) ? .black : .white)
           }
           .modifier(GlobalPositionModifier())
           .onPreferenceChange(GlobalFrameKey.self) { value in
               self.globalFrame = value
           }
           .onTapGesture(coordinateSpace: .global) { location in
               self.globalTap = location
               
               if viewModel.activePaymentButton == .ScheduledDate {
                   viewModel.taps += 1
                   print(viewModel.taps)
                   viewModel.restartTimer()
               }
               
   //            printInfo()
           }
           
           Spacer()
           
           
           ZStack {
               RoundedRectangle(cornerRadius: 20)
                   .fill(
                       (viewModel.activePaymentButton == .Pay) ?
                       Color.bgSecondary :
                           Color.bgSecondary.opacity(0.32)
                   )
                   .frame(width: 100, height: 50)
               
               Text((viewModel.activePaymentButton == .Pay) ? "Tap me now" : "Just a simple button")
                   .foregroundColor((viewModel.activePaymentButton == .Pay) ? .black : .white)
           }
           .modifier(GlobalPositionModifier())
           .onPreferenceChange(GlobalFrameKey.self) { value in
               self.globalFrame = value
           }
           .onTapGesture(coordinateSpace: .global) { location in
               self.globalTap = location
               
               if viewModel.activePaymentButton == .Pay {
                   viewModel.taps += 1
                   print(viewModel.taps)
                   viewModel.restartTimer()
               }
               
   //            printInfo()
           }
           
           Spacer()
           
       }
}


