//
//  OnboardingScreen.swift
//  iosApp
//
//  Created by Alexia Aldea on 01.04.2024.
//

import SwiftUI
import Foundation

class OnboardingViewModel: ObservableObject {
    var userDefaultsService = UserDefaultsService.shared
}

struct OnboardingScreen: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 16) {
                Spacer()
                Text("Keep your application safe")
                    .font(.KronaOne.regular(size: 24))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
                
                Text("Secure your application with Felicia. Sign up to start")
                    .font(.KronaOne.regular(size: 12))
                    .foregroundStyle(Color.fontOnboarding)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                
                Spacer()
            }.padding(.horizontal, 48)
            
            ZStack {
                Image(.icOnboarding)
                    .resizable()
                    .frame(maxWidth: .infinity)
                VStack {
                    Spacer(minLength: 80)
                    ButtonOnboardingView {
                        viewModel.userDefaultsService.setOnboarding(onboardingIsOver: true)
                        navigation.replaceNavigationStack([HomeScreen().asDestination()], animated: true)
                    }.padding(.bottom, 24)
                }
            }
        }.background(Color.bgPrimary)
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .leading, .trailing])
    }
}

struct ButtonOnboardingView: View {
    let action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            Image(.icArrowRightPurple)
                .resizable()
                .frame(width: 32, height: 32)
                .padding(.all, 20)
                .background(
                    Circle().foregroundStyle(Color.bgPrimary)
                )
        }
    }
}

#Preview {
    OnboardingScreen()
}
