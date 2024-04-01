//
//  ContentView.swift
//  iosApp
//
//  Created by Alexia Aldea on 01.04.2024.
//

import SwiftUI

struct StartScreen: View {
    @ObservedObject var viewModel = StartViewModel()
    
    var body: some View {
        if viewModel.getOnboardingStatus() {
            ContentView()
        } else {
            OnboardingScreen()
        }
    }
}

#Preview {
    StartScreen()
}
