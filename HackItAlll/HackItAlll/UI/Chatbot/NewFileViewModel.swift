//
//  NewFileViewModel.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 06.04.2024.
//

import Foundation

enum Completion {
    case completed
    case error(Error)
}

class NewLoanViewModel: BaseViewModel {
    let variants: [Variant] = [
        Variant(title: "Question", description: "Give me loan variants at BCR"),
        Variant(title: "Question", description: "Tell me about BCR"),
        Variant(title: "Question", description: "Tell me how to open a savings account at BCR"),
        Variant(title: "Question", description: "Do I have to be employed to get a loan at BCR?"),
        Variant(title: "Question", description: "Tell me a joke about banks")
    ]
    
    @Published var textMessage: String = ""
    @Published var messages: [Message] = [Message(message: "Hi, Marian! Unsure what type of loan would fit your needs?")]
    @Published var messagesNotSended: Bool = true
    
    func sendMessage() {
        let message = Message(message: textMessage)
        self.messages.append(message)
        
        
        FeliciaService.shared.enhancePrompt(prompt: textMessage)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] message in
                let mess = Message(message: message)
        self?.sendFeliciaMessage(message: mess)
            }.store(in: &self.bag)

        self.textMessage = ""
    }
    
    func sendFeliciaMessage(message: Message) {
        FeliciaService.shared.getFelicia(prompt: message.message)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] message in
                self?.messages.append(message)
            }
            .store(in: &self.bag)
        
//        FeliciaService.shared.getFeliciaFromConversation(conversation: messages, prompt: message.message)
//            .receive(on: DispatchQueue.main)
//            .sink { _ in
//                
//            } receiveValue: { [weak self] message in
//                self?.messages.append(message)
//            }.store(in: &self.bag)
    }
}
