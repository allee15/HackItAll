//
//  TapService.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 07.04.2024.
//

import Foundation
import Combine

class TapService: BaseViewModel {
    static let shared = TapService()
    
    private override init() {}
    
    public func postTapOnce( xStart: Float, yStart: Float, xEnd: Float, yEnd: Float, x: Float, y: Float, roll: Float, pitch: Float) -> AnyPublisher<Bool, Error> {
        return TapAPI.shared.postTapOnce(xStart: xStart, yStart: yStart, xEnd: xEnd, yEnd: yEnd, x: x, y: y, roll: roll, pitch: pitch)
        .eraseToAnyPublisher()
    }

    public func postAllTaps() -> AnyPublisher<Bool, Error> {
        return TapAPI.shared.postAllTaps()
        .eraseToAnyPublisher()
    }

    public func getIsUserError() -> AnyPublisher<Bool, Error> {
        return TapAPI.shared.getIsUserError()
        .eraseToAnyPublisher()
    }
}
