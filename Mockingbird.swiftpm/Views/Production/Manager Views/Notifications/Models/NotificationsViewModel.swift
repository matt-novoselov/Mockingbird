//
//  File.swift
//  
//
//  Created by Matt Novoselov on 21/01/24.
//

import Foundation

class NotificationsViewModel{
    var notifications:[Notification] = [
        Notification(text: "When you eat, the reward center releases dopamine, providing a jolt of satisfaction."), // 0
        
        Notification(text: "This encourages you to eat again in the future."), // 1
        
        Notification(text: "But addictive substances can abuse our reward system."), // 2
        
        Notification(text: "Alcohol stimulates the release of dopamine, tricking your brain into feeling pleasure."), // 3
        
        Notification(text: "The alcohol itself isn't what makes you feel good and it's not healthy."), // 4
        
        Notification(text: "This association between drinking alcohol and feeling good can result in addiction."), // 5
        
        Notification(text: "Addictive use of social media can closely resemble other substance use disorders."), // 6
        
        Notification(text: "Likes, shares, and comments offer an endless amount of immediate rewards, leading to the release of dopamine."), // 7
        
        Notification(text: "Due to our dopamine systems, as we consume more, we actually desire more."), // 8
        
        Notification(text: "When experiencing a gambling win, the brain releases dopamine, creating a desire to gamble more."), // 9
        
        Notification(text: "It’s important to remember that fleeting moments of pleasure are not real happiness."), // 10
        
        Notification(text: "Gambling can become an unhealthy obsession, resulting in financial and personal problems."), // 11
        
        Notification(text: "Addictive drugs produce a pleasurable surge of dopamine up to 10 times higher than a natural reward would."), // 12
        
        Notification(text: "The higher the peak in dopamine, the further below baseline the dopamine drops afterward, and you feel a lack of pleasure."), // 13
        
        Notification(text: "You may find that daily things that used to excite you no longer bring you happiness…"), // 14
        
        Notification(text: "Engage in activities that are meaningful to you – it's the first step towards a brighter future."), // 15
        
        Notification(text: "You are not alone. Your family, relatives, and friends can help you navigate through the storm."), // 16
        
        Notification(text: "Rather than relying on substances or temporary escapes, try to find happiness in the present moment.") // 17

    ]
}
