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
    case bold = "Poppins-Bold"
    case semiBold = "Poppins-SemiBold"
    case regular = "Poppins-Regular"
}

extension Font {
    enum Poppins {
        static func bold(size: CGFloat) -> Font {
            return Font.custom(PoppinsFontNames.bold.rawValue, size: size)
        }
        
        static func semiBold(size: CGFloat) -> Font {
            return Font.custom(PoppinsFontNames.semiBold.rawValue, size: size)
        }
        
        static func regular(size: CGFloat) -> Font {
            return Font.custom(PoppinsFontNames.regular.rawValue, size: size)
        }
    }
}


