//
//  UserService.swift
//  iosApp
//
//  Created by Alexia Aldea on 01.04.2024.
//

import Foundation
import Combine

class UserService: ObservableObject {
    
    private var userDefaultsService = UserDefaultsService.shared
    static let shared = UserService()
    
    private init() { }
}
