//
//  FeliciaService.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 06.04.2024.
//

import Foundation
import Combine

class FeliciaService: BaseViewModel {
    static let shared = FeliciaService()
    
    private override init() {}
    
    public func getFelicia(prompt: String) -> AnyPublisher<Message, Error> {
        return FeliciaAPI.shared.getFelicia(prompt: prompt)
            .eraseToAnyPublisher()
    }
    
    public func getFeliciaFromConversation(conversation: [Message], prompt: String) -> AnyPublisher<Message, Error> {
        return FeliciaAPI.shared.getFeliciaFromConversation(conversation: conversation, prompt: prompt)
            .eraseToAnyPublisher()
    }
}
