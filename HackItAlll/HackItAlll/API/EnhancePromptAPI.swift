//
//  EnhancePromptAPI.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 07.04.2024.
//

import Foundation
import SwiftyJSON
import Combine

class EnhancePromptAPI {
    
    static let shared = EnhancePromptAPI()
    
    private init() {}
    
    public func enhancePrompt(prompt: String) -> Future<String, Error> {
        Future<String, Error> { promise in
            
            var urlComponents = URLComponents(string: "https://f447-81-196-154-84.ngrok-free.app/augment-prompt")
            urlComponents?.queryItems = [
                URLQueryItem(name: "prompt", value:  prompt),
                
            ]
            
            var urlRequest = URLRequest(url: urlComponents!.url!)
            urlRequest.httpMethod = "POST"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else { return }
                guard let data else { return }
                
                do {
                    
                    let json = try JSON(data: data)
                    let result = json["response"]
                    
                    promise(.success(result.stringValue))
                    
                } catch(let error) {
                    print(error)
                    promise(.failure(error))
                }
                
            }
            
            dataTask.resume()
        }
    }
}
