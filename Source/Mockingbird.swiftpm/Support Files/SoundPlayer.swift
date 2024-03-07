//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 17/01/24.
//

import AudioToolbox

func playSound(name: String, ext: String) {
    guard let soundURL = Bundle.main.url(forResource: name, withExtension: ext) else {
        print("[!] Error playing audio file")
        return
    }
    
    var soundID: SystemSoundID = 0
    AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
    
    // Play the sound
    AudioServicesPlaySystemSound(soundID)
}
