//
//  ErrorScreen.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 07.04.2024.
//

import SwiftUI

struct ErrorScreen: View {
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        VStack {
            Text("An error occurred!")
                .font(.KronaOne.regular(size: 24))
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, 52)
            
            Image(.icError)
                .resizable()
                .frame(width: 112, height: 112)
                .padding(.bottom, 16)
            
            Text("Felicia isn’t feeling so well right now...")
                .font(.KronaOne.regular(size: 24))
                .foregroundStyle(Color(hex: "#FFD7FB"))
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 80)
            
            Button {
                navigation.replaceNavigationStack([HomeScreen().asDestination()], animated: true)
            } label: {
                Text("Back to home")
                    .font(.KronaOne.regular(size: 16))
                    .foregroundStyle(Color.bgPrimary)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color(hex: "#FFD7FB"))
                    .cornerRadius(12, corners: .allCorners)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.bgPrimary)
    }
}

#Preview {
    ErrorScreen()
}
