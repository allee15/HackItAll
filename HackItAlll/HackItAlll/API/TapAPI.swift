//
//  TapAPI.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 07.04.2024.
//

import Foundation
import SwiftyJSON
import Combine

var allTaps: [Float] = []

class TapAPI {
    
    static let shared = TapAPI()
    
    private init() {}
    
    public func postTapOnce( xStart: Float, yStart: Float, xEnd: Float, yEnd: Float, x: Float, y: Float, roll: Float, pitch: Float) -> Future<String, Error> {
        
        Future<String, Error> { promise in
            allTaps.append(xStart)
            allTaps.append(yStart)
            allTaps.append(xEnd)
            allTaps.append(yEnd)
            allTaps.append(x)
            allTaps.append(y)
            allTaps.append(roll)
            allTaps.append(pitch)
            
            var urlComponents = URLComponents(string: "https://f447-81-196-154-84.ngrok-free.app/model")
            urlComponents?.queryItems = [
                URLQueryItem(name: "x_start", value:  String(xStart)),
                URLQueryItem(name: "y_start", value:  String(yStart)),
                URLQueryItem(name: "x_end", value:  String(xEnd)),
                URLQueryItem(name: "y_end", value:  String(yEnd)),
                URLQueryItem(name: "x", value:  String(x)),
                URLQueryItem(name: "y", value: String(y)),
                URLQueryItem(name: "roll", value:  String(roll))
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

    public func postAllTaps() -> Future<String, Error> {
        Future<String, Error> { promise in
            print(allTaps)
            var urlComponents = URLComponents(string: "https://f447-81-196-154-84.ngrok-free.app/train-model")
            var coordsAsString = allTaps.map({String($0)})
            coordsAsString.append(name)
            urlComponents?.queryItems = [
                URLQueryItem(name: "all_coords", value:  coordsAsString.joined(separator: ","))
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

    public func getIsUserError() -> Future<String, Error> {
        Future<String, Error> { promise in
            
            var urlComponents = URLComponents(string: "https://f447-81-196-154-84.ngrok-free.app/current-user")
            urlComponents?.queryItems = [
            ]
            
            var urlRequest = URLRequest(url: urlComponents!.url!)
            urlRequest.httpMethod = "GET"
            
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
