//
//  Card.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import Foundation

struct Card: Equatable {
    let id: Int
    let series: String
    let thumbnailUrl: ImageResource
    let detailsIcon: ImageResource
    let balance: String
}
