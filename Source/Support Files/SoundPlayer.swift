//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 17/01/24.
//

import AudioToolbox

// Function that locates and plays sound
func playSound(name: String, ext: String) {
    
    // Locate the sound in the Resources
    guard let soundURL = Bundle.main.url(forResource: name, withExtension: ext) else {
        print("[!] Error playing audio file")
        return
    }
    
    var soundID: SystemSoundID = 0
    AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
    
    // Play the sound
    AudioServicesPlaySystemSound(soundID)
}
