//
//  Font.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import SwiftUI

extension Font {
    
    static func appFont(_ font: CustomFont = .openSans, weight: UIFont.Weight, size: CGFloat) -> Font {
        return .custom(font.filename(weight), size: size)
    }
}
