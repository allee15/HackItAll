//
//  ContentView.swift
//  iosApp
//
//  Created by Alexia Aldea on 01.04.2024.
//

import SwiftUI
import Foundation

class StartViewModel: ObservableObject {
    var userDefaultsService = UserDefaultsService.shared
    
    func getOnboardingStatus() -> Bool {
        return userDefaultsService.getOnboardingStatus()
    }
}

struct StartScreen: View {
    @ObservedObject var viewModel = StartViewModel()
    
    var body: some View {
        if viewModel.getOnboardingStatus() {
            HomeScreen()
        } else {
            OnboardingScreen()
        }
    }
}

#Preview {
    StartScreen()
}
