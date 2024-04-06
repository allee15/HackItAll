//
//  BiometricsScreen.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import SwiftUI

struct PaymentBiometricsView: View {
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
           VStack {
               ZStack {
                   RoundedRectangle(cornerRadius: 20)
                       .fill(
                           (viewModel.activePaymentButton == .Iban) ?
                               .blue :
                                   .gray
                       )
                       .frame(height: 50)
                   
                   Text("IBAN")
                       .foregroundColor(.white)
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
                                   .blue :
                                       .gray
                           )
                           .frame(height: 50)
                       
                       Text("Amount")
                           .foregroundColor(.white)
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
                                   .blue :
                                       .gray
                           )
                           .frame(height: 50)
                       
                       Text("Currency")
                           .foregroundColor(.white)
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
                               .blue :
                                   .gray
                       )
                       .frame(height: 100)
                   
                   Text("Message")
                       .foregroundColor(.white)
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
                           .blue :
                               .gray
                   )
                   .frame(height: 50)
               
               Text("Scheduled Payment Date")
                   .foregroundColor(.white)
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
                           .blue :
                               .gray
                   )
                   .frame(width: 100, height: 50)
               
               Text("Pay")
                   .foregroundColor(.white)
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


