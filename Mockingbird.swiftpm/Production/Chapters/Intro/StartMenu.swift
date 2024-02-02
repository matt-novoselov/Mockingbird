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
    
    var jigglingArray: [String] = ["num1", "num2", "num3", "num4"]
    @State private var currentIndex = 0
    @State var isButtonPressed: Bool = false
    
    var body: some View {
        ZStack {
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            GeometryReader { geometry in
                HStack{
                    Spacer()
                    
                    Button(
                        action: {
                            if isButtonPressed{
                                return
                            }
                            else{
                                isButtonPressed = true
                            }
                            playSound(name: "pop", ext: "mp3")
                            
                            if let buttonPosition = GlobalPositionUtility.getGlobalPosition(view: geometry) {
                                ParticleView.spawnParticle(xpos: buttonPosition.x, ypos: buttonPosition.y)
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                transitionManagerObservable.transitionToScene?(2)
                            }
                        }
                    ) {
                        VStack{
                            Image(jigglingArray[currentIndex])
                                .interpolation(.high)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .onAppear {
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
