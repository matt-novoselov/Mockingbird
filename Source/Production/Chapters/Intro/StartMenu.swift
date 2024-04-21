//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct StartMenu: View {
    
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    // Array of images for jiggling animation
    var jigglingArray: [String] = ["num1", "num2", "num3", "num4"]
    
    // Current index of displayed image from the array
    @State private var currentIndex = 0
    
    // Lock accidental transitions after one tap
    @State var isButtonPressed: Bool = false
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            GeometryReader { geometry in
                HStack{
                    Spacer()
                    
                    Button(
                        action: {
                            
                            // Return if button was already pressed
                            if isButtonPressed{
                                return
                            }
                            else{
                                isButtonPressed = true
                            }
                            
                            // Play sound
                            playSound(name: "Start_click", ext: "mp3")
                            
                            // Spawn particles
                            if let buttonPosition = GlobalPositionUtility.getGlobalPosition(view: geometry) {
                                ParticleView.spawnParticle(xpos: buttonPosition.x, ypos: buttonPosition.y)
                            }
                            
                            // Transition to the next scene after particles animation is finished
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                transitionManagerObservable.transitionToScene?(2)
                            }
                        }
                    ) {
                        VStack{
                            // Animated jiggling image
                            Image(jigglingArray[currentIndex])
                                .interpolation(.high)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .onAppear {
                                    // Change image each 0.1 seconds
                                    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                                        currentIndex = (currentIndex + 1) % jigglingArray.count
                                    }
                                }
                            
                            Image("button_line")
                                .interpolation(.high)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 400)
                        }
                    }
                    .buttonStyle(NoOpacityButtonStyle())
                    
                    Spacer()
                }
            }
            .frame(height: 150)
        }
    }
}



#Preview {
    LayersManager(initialView: StartMenu())
}

