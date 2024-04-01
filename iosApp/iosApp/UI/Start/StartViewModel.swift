//
//  StartViewModel.swift
//  iosApp
//
//  Created by Alexia Aldea on 01.04.2024.
//

import Foundation

class StartViewModel: ObservableObject {
    var userDefaultsService = UserDefaultsService.shared
    
    func getOnboardingStatus() -> Bool {
        return userDefaultsService.getOnboardingStatus()
    }
}
