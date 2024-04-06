//
//  TapAPI.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 07.04.2024.
//

import Foundation
import SwiftyJSON
import Combine

class TapAPI {
    
    static let shared = TapAPI()
    var allTaps: [Float] = []
    
    private init() {}
    
    public func postTapOnce( xStart: Float, yStart: Float, xEnd: Float, yEnd: Float, x: Float, y: Float, roll: Float, pitch: Float) -> Future<Bool, Error> {
        
        Future<Bool, Error> { promise in
            self.allTaps.append(xStart)
            self.allTaps.append(yStart)
            self.allTaps.append(xEnd)
            self.allTaps.append(yEnd)
            self.allTaps.append(x)
            self.allTaps.append(y)
            self.allTaps.append(roll)
            self.allTaps.append(pitch)
            
            var urlComponents = URLComponents(string: "http://127.0.0.1:\(PORT)/tap")
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
                    let result = json["tap"]
                    
                    promise(.success(result.boolValue))
                    
                } catch(let error) {
                    print(error)
                    promise(.failure(error))
                }
                
            }
            
            dataTask.resume()
        }
    }

    public func postAllTaps() -> Future<Bool, Error> {
        Future<Bool, Error> { promise in
            
            var urlComponents = URLComponents(string: "http://127.0.0.1:\(PORT)/tap_all")
            let coordsAsString = self.allTaps.map({String($0)})
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
                    let result = json["tap_all"]
                    
                    promise(.success(result.boolValue))
                    
                } catch(let error) {
                    print(error)
                    promise(.failure(error))
                }
                
            }
            
            dataTask.resume()
        }
    }

    public func getIsUserError() -> Future<Bool, Error> {
        Future<Bool, Error> { promise in
            
            var urlComponents = URLComponents(string: "http://127.0.0.1:\(PORT)/user_error")
            urlComponents?.queryItems = [
            ]
            
            var urlRequest = URLRequest(url: urlComponents!.url!)
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else { return }
                guard let data else { return }
                
                do {
                    
                    let json = try JSON(data: data)
                    let result = json["user_error"]
                    
                    promise(.success(result.boolValue))
                    
                } catch(let error) {
                    print(error)
                    promise(.failure(error))
                }
                
            }
            
            dataTask.resume()
        }
    }
}
