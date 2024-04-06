//
//  BiometricBehaviourView.swift
//  HackathonTest
//
//  Created by Bogdan-Gabriel Toma on 03.04.2024.
//

import SwiftUI

struct BiometricScreen: View {
    
    @StateObject var viewModel = BiometricViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
            
            VStack {
                switch viewModel.taps {
                    
                case ..<20:
                    HomeBiometricsView(viewModel: viewModel)
                    
                case 20..<40:
                    PaymentBiometricsView(viewModel: viewModel)

                case 40..<60:
                    TransactionBiometricsView(viewModel: viewModel)
                    
                default:
                    let _ = dismiss()
                }
            }
            .padding(20)
        }
    }
}
