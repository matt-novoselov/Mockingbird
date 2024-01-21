//
//  FontModel.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 29/12/23.
//

import SwiftUI

func getFont(size: CGFloat) -> Font {
    let cfURL = Bundle.main.url(forResource: "PatrickHand", withExtension: "ttf")! as CFURL
    
    CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
    
    let uiFont = UIFont(name: "Patrick Hand", size:  size)
    
    return Font(uiFont ?? UIFont())
}
