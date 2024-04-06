//
//  Variant.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 06.04.2024.
//

import Foundation

struct Variant {
    let id = UUID()
    let title: String
    let description: String
}

struct Message {
    let id = UUID()
    let message: String
}

struct Friend {
    let id = UUID()
    let name: String
    let phone: String
}
