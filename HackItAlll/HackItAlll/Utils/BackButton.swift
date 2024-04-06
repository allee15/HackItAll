//
//  BackButton.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import SwiftUI

struct BackButton: View {
    let text: String
    
    var body: some View {
        HStack {
            Image(.icArrowLeft)
                .resizable()
                .frame(width: 12, height: 16)
                .padding(.trailing, 8)
            
            Text(text)
                .font(.KronaOne.regular(size: 20))
                .foregroundStyle(Color.white)
            
            Spacer()
        }
    }
}


