//
//  LaunchscreenRepresentable.swift
//  iosApp
//
//  Created by Alexia Aldea on 01.04.2024.
//

import SwiftUI

struct LaunchscreenRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        UIStoryboard(name: "LaunchScreen", bundle: .main).instantiateInitialViewController()!
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }
}
