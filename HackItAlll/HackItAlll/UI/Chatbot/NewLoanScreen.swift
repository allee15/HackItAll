//
//  NewLoanScreen.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 06.04.2024.
//

import SwiftUI

struct NewLoanScreen: View {
    @StateObject private var viewModel = NewLoanViewModel()
    @EnvironmentObject private var navigation: Navigation
    
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                navigation.pop(animated: true)
            } label: {
                BackButton(text: viewModel.textMessage.isEmpty ? "Get new loan" : "Chat with Felicia") 
            }
            
            ScrollViewReader { scrollProxy in
                ScrollView(showsIndicators: false) {
                    if viewModel.messagesNotSended {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(viewModel.variants, id: \.id) { variant in
                                Button {
                                    viewModel.textMessage = variant.description
                                    viewModel.messagesNotSended = false
                                } label: {
                                    NewLoanWidgetView(title: variant.title, description: variant.description)
                                }
                            }
                        }.padding(.top, 32)
                    }
                    
                    Spacer(minLength: 100)
                    
                    ForEach(Array(viewModel.messages.enumerated()), id: \.element.id) { index, message in
                        let wasSentByFelicia = index % 2 == 0
                        VStack(spacing: 0) {
                            HStack(spacing: 8) {
                                if wasSentByFelicia {
                                    Image(.imgFelicia)
                                        .resizable()
                                        .frame(width: 48, height: 56)
                                }
                                
                                Text(message.message)
                                    .font(.KronaOne.regular(size: 12))
                                    .foregroundStyle(Color.bgPrimary)
                                    .multilineTextAlignment(.leading)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(wasSentByFelicia ? Color.chatBg : Color.chatBg.opacity(0.76))
                                    .cornerRadius(16)
                                    .frame(width: UIScreen.main.bounds.width * 0.8, alignment: wasSentByFelicia ? .leading : .trailing)
                                    .id(message.id)
                                    .onChange(of: viewModel.messages.count, perform: { _ in
                                        scrollProxy.scrollTo(viewModel.messages.last?.id)
                                    })
                            }
                        }.padding(.horizontal, 8)
                            .padding(.bottom, 12)
                    }
                }
            }
            
            if !viewModel.messagesNotSended {
                HStack(spacing: 0) {
                    TextField("Ask Felicia", text: $viewModel.textMessage, onCommit: {
                        viewModel.sendMessage()
                    })
                    .textFieldStyle(.plain)
                    .placeHolderMessage(when: viewModel.textMessage.isEmpty) {
                        Text("")
                            .foregroundColor(.clear)
                    }
                    
                    Button {
                        if !viewModel.textMessage.isEmpty {
                            viewModel.sendMessage()
                        }
                    } label: {
                        Image(.icSendBlack)
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                }.padding(.horizontal, 12)
                    .padding(.vertical, 16)
                    .background(Color.chatBg.opacity(0.76))
                    .cornerRadius(16, corners: .allCorners)
                    .padding(.bottom, 20)
                    
            }
        }.padding(.horizontal, 24)
            .background(Color.bgPrimary)
    }
}

struct NewLoanWidgetView: View {
    let title: String
    let description: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .foregroundStyle(Color.white)
                .font(.KronaOne.regular(size: 12))
                .multilineTextAlignment(.leading)
            
            Text(description)
                .foregroundStyle(Color.beigeText)
                .font(.KronaOne.regular(size: 14))
                .multilineTextAlignment(.leading)
        }.padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.bgSecondary.opacity(0.32))
            .cornerRadius(16, corners: .allCorners)
            .border(Color.bgSecondary, width: 1, cornerRadius: 16)
            .padding(.horizontal, 20)
    }
}

#Preview {
    NewLoanScreen()
}
