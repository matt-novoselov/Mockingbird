//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 17/01/24.
//

import AudioToolbox

func playSound() {
    guard let soundURL = Bundle.main.url(forResource: "pop", withExtension: "mp3") else {
        return
    }
    
    var soundID: SystemSoundID = 0
    AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
    
    // Play the sound
    AudioServicesPlaySystemSound(soundID)
}
