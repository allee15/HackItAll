//
//  OnboardingViewModel.swift
//  iosApp
//
//  Created by Alexia Aldea on 01.04.2024.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var pageIndex = 0
    var userDefaultsService = UserDefaultsService.shared
}
