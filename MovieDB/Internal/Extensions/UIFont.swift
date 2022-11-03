//
//  UIFont.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import UIKit

enum CustomFont {
    
    case openSans
    
    var baseName: String {
        switch self {
        case .openSans: return "OpenSans"
        }
    }
    
    func filename(_ forWeight: UIFont.Weight) -> String {
        switch forWeight {
        case .semibold: return baseName + "-SemiBold"
        case .bold: return baseName + "-Bold"
        default: return baseName + "-Bold"
        }
    }
}

extension UIFont {
    
    static func appFont(_ font: CustomFont = .openSans, weight: UIFont.Weight = .bold, size: CGFloat = 16) -> UIFont {
        return UIFont(name: font.filename(weight), size: size)! // playing dangerous with this force unwrap
    }
}
