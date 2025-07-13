//
//  TextStyle.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//

import SwiftUI

enum FontFamily {
    case montserrat
    case lato

    func fontName(weight: Font.Weight) -> String {
        switch self {
        case .montserrat:
            switch weight {
            case .bold:
                return "Montserrat-Bold"
            case .semibold:
                return "Montserrat-SemiBold"
            case .medium:
                return "Montserrat-Medium"
            default:
                return "Montserrat-Regular"
            }
        case .lato:
            switch weight {
            case .black:
                return "Lato-Black"
            case .bold:
                return "Lato-Bold"
            case .light:
                return "Lato-Light"
            case .medium:
                return "Lato-Regular"
            case .regular:
                return "Lato-Regular"
            case .semibold:
                return "Lato-Bold"
            case .thin:
                return "Lato-Light"
            case .ultraLight:
                return "Lato-Light"
            default:
                return "Lato-Regular"
            }
        }
    }
}

enum TextStyle {
    case title1, title2, title3
    case headline, subheadline
    case body, callout
    case caption, caption2
    case footnote

    func font(weight overrideWeight: Font.Weight? = nil) -> Font {
        let (family, baseWeight, size): (FontFamily, Font.Weight, CGFloat) = {
            switch self {
            case .title1:     return (.montserrat, .bold, 28)
            case .title2:     return (.montserrat, .bold, 22)
            case .title3:     return (.montserrat, .bold, 20)
            case .headline:   return (.lato, .bold, 17)
            case .subheadline:return (.lato, .regular, 15)
            case .body:       return (.lato, .regular, 17)
            case .callout:    return (.lato, .regular, 16)
            case .caption:    return (.lato, .light, 13)
            case .caption2:   return (.lato, .light, 11)
            case .footnote:   return (.lato, .regular, 12) // italic can be handled separately
            }
        }()

        let finalWeight = overrideWeight ?? baseWeight
        let fontName = family.fontName(weight: finalWeight)
        return .custom(fontName, size: size)
    }
}
