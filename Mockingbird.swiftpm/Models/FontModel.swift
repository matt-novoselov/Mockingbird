//
//  FontModel.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 29/12/23.
//

import SwiftUI

func getFont(size: CGFloat) -> Font {
    let cfURL = Bundle.main.url(forResource: "RedBurger", withExtension: "otf")! as CFURL
    
    CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
    
    let uiFont = UIFont(name: "RED BURGER", size:  size)
    
    return Font(uiFont ?? UIFont())
}
