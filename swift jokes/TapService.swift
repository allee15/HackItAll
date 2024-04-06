import Foundation
import Combine

class TapService: BaseViewModel<Any> {
    static let shared = TapService()
    
    private override init() {}
    
    public func postTapOnce(
        xStart: Float, yStart: Float, 
        xEnd: Float, yEndL Float, x: Float, y: Float, 
        roll: Float, pitch: Float, yaw: Float
    ) -> AnyPublisher<Bool, Error> {
        return TapAPI.shared.postAllTaps(
            xStart: xStart, yStart: yStart, 
            xEnd: xEnd, yEnd: yEnd, x: x, y: y, 
            roll: roll, pitch: pitch, yaw: yaw
        )
        .eraseToAnyPublisher()
    }

    public func postAllTaps(coords: [Float]) -> AnyPublisher<Bool, Error> {
        return TapAPI.shared.postAllTaps(coords: coords)
        .eraseToAnyPublisher()
    }

    public func getIsUserError() -> AnyPublisher<Bool, Error> {
        return TapAPI.shared.getIsUserError()
        .eraseToAnyPublisher()
    }
}