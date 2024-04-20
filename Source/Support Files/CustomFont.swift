//
//  FontModel.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 29/12/23.
//

import SwiftUI

// Function that locates and returns font
func getFont(size: CGFloat) -> Font {
    
    // Find Patrick Hand font in the Resource folder
    if let cfURL = Bundle.main.url(forResource: "PatrickHand", withExtension: "ttf") as CFURL? {
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        if let uiFont = UIFont(name: "Patrick Hand", size:  size) {
            return Font(uiFont)
        }
    }
    
    // Default font in case of any failure
    return Font.system(size: size)
}
