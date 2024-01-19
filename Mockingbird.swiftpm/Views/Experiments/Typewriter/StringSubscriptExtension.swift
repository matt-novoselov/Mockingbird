//
//  File.swift
//  
//
//  Created by Matt Novoselov on 19/01/24.
//

import Foundation

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
