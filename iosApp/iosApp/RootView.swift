//
//  RootView.swift
//  iosApp
//
//  Created by Alexia Aldea on 01.04.2024.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var navigation: Navigation
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationHostView(navigation: navigation)
        }.ignoresSafeArea()
    }
    
}

