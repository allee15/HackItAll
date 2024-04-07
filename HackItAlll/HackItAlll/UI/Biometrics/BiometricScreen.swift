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
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.bgPrimary)
                .ignoresSafeArea()
            
            VStack {
                switch viewModel.taps {
                    
                case ..<20:
                    HomeBiometricsView(viewModel: viewModel)
                    
                case 20..<40:
                    TransferBiometricView(viewModel: viewModel)

                case 40..<60:
                    ExpenseRoundupBiometricView(viewModel: viewModel)
                    
                default:
                    let _ = viewModel.postAllTaps()
                    let _ = dismiss()
                }
            }
            .padding(20)
        }.onReceive(viewModel.eventSubject) { event in
            switch event {
            case .completed:
                navigation.replaceNavigationStack([HomeScreen().asDestination()], animated: true)
            case .loading:
                navigation.push(LoadingScreen().asDestination(), animated: true)
            case .failure(_):
                navigation.push(ErrorScreen().asDestination(), animated: true)
            }
        }
    }
}
