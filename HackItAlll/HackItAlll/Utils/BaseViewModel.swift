//
//  BaseViewModel.swift
//  iosApp
//
//  Created by Alexia Aldea on 01.04.2024.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    var bag = Set<AnyCancellable>()
    
    func cancel() {
        bag.forEach { $0.cancel() }
        bag.removeAll()
    }
}
