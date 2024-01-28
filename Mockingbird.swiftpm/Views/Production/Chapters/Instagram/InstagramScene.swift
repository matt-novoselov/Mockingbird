//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct InstagramScene: View {
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State var darkSlider: Double = 0
    @State var heavenSlider: Double = 0
    
    @State var countVisitsToHeaven: Int = 0
    @State var isInHeaven: Bool = false
    
    @State private var shouldChangePost: Bool = false
    
    @State private var imageSize: CGSize = .zero
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: $heavenSlider)
            
            GeometryReader{ geomtry in
                let wm = geomtry.size.width / 3000
                let hm = geomtry.size.height / 3000
                
                ZStack {
                    InstagramViewController(action: handleOnReaction, shouldChangePost: $shouldChangePost)
                        .environmentObject(transitionManagerObservable)
                        .padding()
                        .frame(width: imageSize.width * wm, height: imageSize.height * hm)
                        .mask(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: imageSize.width * wm, height: imageSize.height * hm)
                        )
                    
                    Image("iphone_bezel")
                        .interpolation(.high)
                        .resizable()
                        .scaledToFit()
                        .onAppear {
                            imageSize = UIImage(named: "iphone_bezel")?.size ?? CGSize(width: 300, height: 600)
                        }
                        .allowsHitTesting(false)
                }
                .padding(.all, 50)
            }

            
            
            //                .overlay(
            //                    InstagramViewController(action: handleOnReaction, shouldChangePost: $shouldChangePost)
            //                        .environmentObject(transitionManagerObservable)
            //                        .mask(
            //                            RoundedRectangle(cornerRadius: 10)
            //                                .fill(Color.white)
            //                                .frame(width: 320, height: 600) // Adjust dimensions according to your bezel image size
            //                        )
            //                )
            //                .padding(.all, 50)
        }
    }
    
    func handleOnReaction(){
        let heavenValues: [(Double, Double)] = [
            (0.25, 0.05),
            (0.25, 0.1),
            (0.25, 0.15),
        ]
        
        if countVisitsToHeaven<3{
            let tuple = heavenValues[countVisitsToHeaven]
            goToHeaven(heavenSliderGoal: tuple.0, darkSliderAfterwards: tuple.1)
        }
        else{
            notificationManager.callNotification(
                ID: 9,
                arrowAction: {
                    transitionManagerObservable.transitionToScene?(6)
                }
            )
        }
    }
    
    func goToHeaven(heavenSliderGoal: Double?, darkSliderAfterwards: Double?){
        notificationManager.closeNotification()
        
        countVisitsToHeaven+=1
        isInHeaven = true
        let animationDuration = 2.0
        
        withAnimation(.easeInOut(duration: animationDuration)) {
            heavenSlider = heavenSliderGoal ?? 1.0
        } completion: {
            withAnimation(.easeInOut(duration: 0.5)) {
                darkSlider = darkSliderAfterwards ?? darkSlider
            }
            
            withAnimation(.easeInOut(duration: animationDuration)) {
                heavenSlider = 0
            } completion: {
                // handle end of visit to heaven
                
                isInHeaven = false
                
                // transition to next post
                // P.S. this is a very weird way of calling a function
                shouldChangePost.toggle()
                
                if countVisitsToHeaven == 1{
                    notificationManager.callNotification(ID: 7)
                }
                else if countVisitsToHeaven == 2{
                    notificationManager.callNotification(ID: 8)
                }
            }
        }
    }
}

#Preview {
    LayersManager(initialView: InstagramScene())
}
