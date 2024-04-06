//
//  LoadingScreen.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        VStack {
            Text("Securing your application, please wait")
                .font(.KronaOne.regular(size: 16))
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, 70)
            
            LoaderView()
            
            Spacer(minLength: 80)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.bgPrimary)
    }
}

#Preview {
    LoadingScreen()
}
