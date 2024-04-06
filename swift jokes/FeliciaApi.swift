//
//  FeliciaAPI.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 06.04.2024.
//

import Foundation
import SwiftyJSON
import Combine

let PORT: String = "5000"

class FeliciaAPI {
    static let shared = FeliciaAPI()
    
    private init() {}
    
    public func getFelicia(prompt: String) -> Future<Message, Error> {
        Future<Message, Error> { promise in
            
            
            var urlComponents = URLComponents(string: "http://127.0.0.1:\(PORT)/generate")
            urlComponents?.queryItems = [
                URLQueryItem(name: "prompt", value:  prompt),
                URLQueryItem(name: "max_len", value: "200")
            ]
            
            var urlRequest = URLRequest(url: urlComponents!.url!)
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else { return }
                guard let data else { return }
                
                do {
                    
                    let json = try JSON(data: data)
                    let message = Message(message: json["generated_text"].stringValue)
                    
                    promise(.success(message))
                    
                } catch(let error) {
                    print(error)
                    promise(.failure(error))
                }
                
            }
            
            dataTask.resume()
        }
    }

    public func getFeliciaFromConversation(conversation: [Message], prompt: String) -> Future<Message, Error> {
        Future<Message, Error> { promise in
            
            Future<Message, Error> { promise in
            
            let chatHistory = "["
            for (index, message) in conversation.enumerated() {
                if index % 2 == 1 {
                    chatHistory.append("{\"role\": \"USER\", \"message\": \" \(message.message)\"")
                } else {
                    chatHistory.append("{\"role\": \"CHATBOT\", \"message\": \" \(message.message)\"")
                }
            }
            chatHistory.append("]")

            var urlComponents = URLComponents(string: "http://127.0.0.1:\(PORT)/generate_with_context")
            urlComponents?.queryItems = [
                URLQueryItem(name: "chat_history", value:  chat_history),
                URLQueryItem(name: "message", value: prompt)
            ]
            
            var urlRequest = URLRequest(url: urlComponents!.url!)
            urlRequest.httpMethod = "POST"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else { return }
                guard let data else { return }
                
                do {
                    
                    let json = try JSON(data: data)
                    let message = Message(message: json["generated_text"].stringValue)
                    
                    promise(.success(message))
                    
                } catch(let error) {
                    print(error)
                    promise(.failure(error))
                }
                
            }
            
            dataTask.resume()
        }
    }
}
