//
//  Fonts.swift
//  iosApp
//
//  Created by Alexia Aldea on 01.04.2024.
//

import Foundation
import SwiftUI
import UIKit

fileprivate enum PoppinsFontNames: String {
    case krona = "KronaOne-Regular"
}

extension Font {
    enum KronaOne {
        static func regular(size: CGFloat) -> Font {
            return Font.custom(PoppinsFontNames.krona.rawValue, size: size)
        }
    }
}


