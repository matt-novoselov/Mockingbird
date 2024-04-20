//
//  File.swift
//  
//
//  Created by Matt Novoselov on 20/01/24.
//

import Foundation

// Instagram Post Model
struct InstagramPost: Identifiable {
    var id = UUID()
    var username: String
    var postedTimeAgo: String
    var image: String
}
