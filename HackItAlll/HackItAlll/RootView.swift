//
//  RootView.swift
//  iosApp
//
//  Created by Alexia Aldea on 01.04.2024.
//

import SwiftUI
import Combine

var name: String = ""

class RootViewModel: BaseViewModel {
    
    private var isBinded = false
    
    private var timer: Timer?
    
    func bind() {
        if isBinded {return}
        isBinded = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
            self?.makeAPICall()
        }
    }
    
    private func makeAPICall() {
        TapAPI.shared.getIsUserError()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] response in
                name = response
            }.store(in: &bag)

    }
    
    deinit {
        timer?.invalidate()
        self.cancel()
    }
}

struct RootView: View {
    @ObservedObject var navigation: Navigation
    @StateObject var viewModel = RootViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationHostView(navigation: navigation)
                .onAppear {
                    viewModel.bind()
                }
            
            VStack {
                HStack {
                    Spacer()
                    
                    if !name.isEmpty {
                        Text(name)
                            .foregroundColor(.black)
                            .padding(.all, 12)
                            .background(Color(hex: "#E6D7FF"))
                            .cornerRadius(12)
                            .padding()
                    }
                }.padding(.top, 32)
                Spacer(minLength: 80)
            }
        }
        .ignoresSafeArea()
    }
    
}

