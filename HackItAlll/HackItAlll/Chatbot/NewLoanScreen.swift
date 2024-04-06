//
//  NewLoanScreen.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 06.04.2024.
//

import SwiftUI

class NewLoanViewModel: BaseViewModel {
    let variants: [Variant] = [
        Variant(title: "George", description: "dadafrsfjkdgnfevkfjsdbghvufdhjskzbgvfdjshkjdbgnv"),
        Variant(title: "George", description: "dadafrsfjkdgnfevkfjsdbghvufdhjskzbgvfdjshkjdbgnv"),
        Variant(title: "George", description: "dadafrsfjkdgnfevkfjsdbghvufdhjskzbgvfdjshkjdbgnv"),
        Variant(title: "George", description: "dadafrsfjkdgnfevkfjsdbghvufdhjskzbgvfdjshkjdbgnv"),
        Variant(title: "George", description: "dadafrsfjkdgnfevkfjsdbghvufdhjskzbgvfdjshkjdbgnv")
    ]
    
    @Published var textMessage: String = ""
    @Published var messages: [Message] = [Message(message: "Hi, Marian! Unsure what type of loan would fit your needs?")]
    
    func sendMessage() {
        let message = Message(message: textMessage)
        self.messages.append(message)
        self.textMessage.removeAll()
    }
}

struct NewLoanScreen: View {
    @StateObject private var viewModel = NewLoanViewModel()
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        VStack(spacing: 0) {
            BackButton(text: viewModel.textMessage.isEmpty ? "Get new loan" : "Chat with Felicia") {
                navigation.pop(animated: true)
            }.padding(.horizontal, 24)
            
            ScrollViewReader { scrollProxy in
                ScrollView(showsIndicators: false) {
                    if viewModel.textMessage.isEmpty {
                        ForEach(viewModel.variants, id: \.id) { variant in
                            Button {
                                viewModel.textMessage = variant.description
                            } label: {
                                NewLoanWidgetView(title: variant.title, description: variant.description)
                            }
                            .padding(.bottom, 16)
                        }
                    }
                    
                    ForEach(viewModel.messages, id: \.id) { message in
                        let wasSentByMe = viewModel.messages.isEmpty
                        VStack(spacing: 0) {
                            HStack(spacing: 8) {
                                if !wasSentByMe {
                                    Image(.imgFelicia)
                                        .resizable()
                                        .frame(width: 48, height: 48)
                                }
                                
                                Text(message.message)
                                    .font(.KronaOne.regular(size: 12))
                                    .foregroundStyle(Color.bgPrimary)
                                    .multilineTextAlignment(.leading)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(wasSentByMe ? Color.chatBg : Color.chatBg.opacity(0.76))
                                    .cornerRadius(16)
                                    .frame(width: UIScreen.main.bounds.width * 0.8, alignment: wasSentByMe ? .trailing : .leading)
                                    .id(message.id)
                                    .onChange(of: viewModel.messages.count, perform: { _ in
                                        scrollProxy.scrollTo(viewModel.messages.last?.id)
                                    })
                            }
                        }.padding(.horizontal, 8)
                            .padding(.bottom, 12)
                    }
                    
                    Spacer(minLength: 100)
                    
                    if !viewModel.textMessage.isEmpty {
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
                }
            }.padding(.top, 32)
                .padding(.horizontal, 24)
            
        }.background(Color.bgPrimary)
    }
}

struct NewLoanWidgetView: View {
    let title: String
    let description: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .foregroundStyle(Color.white)
                .font(.KronaOne.regular(size: 16))
                .multilineTextAlignment(.leading)
            
            Text(description)
                .foregroundStyle(Color.beigeText)
                .font(.KronaOne.regular(size: 8))
                .multilineTextAlignment(.leading)
        }.padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.bgSecondary.opacity(0.32))
            .cornerRadius(16, corners: .allCorners)
            .border(Color.bgSecondary, width: 1, cornerRadius: 16)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    NewLoanScreen()
}
