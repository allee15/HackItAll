//
//  RootView.swift
//  iosApp
//
//  Created by Alexia Aldea on 01.04.2024.
//

import SwiftUI

class RootViewModel: BaseViewModel {
    
    private var isBinded = false
      
    func bind() {
        if isBinded {return}
        isBinded = true
    }
}

struct RootView: View {
    @ObservedObject var navigation: Navigation
//    @ObservedObject private var bottomSheetManager: BottomSheetManager.instance
    @StateObject var viewModel = RootViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationHostView(navigation: navigation)
                .onAppear {
                    viewModel.bind()
                }
        }
        .ignoresSafeArea()
    }
    
}

