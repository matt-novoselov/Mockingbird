//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct GamblingScene: View {
    
    @EnvironmentObject var transitionManagerObservable: TransitionManagerObservable
    @EnvironmentObject var notificationManager: NotificationManager
    
    // Property that controls value of the dark background
    @State public var darkSlider: Double = 0.15
    
    // Property that controls value of the heaven background
    @State var heavenSlider: Double = 0
    
    // Property that controls if there is currently a coin inserted in to the machine
    @State var isCoinInsertedInMachine: Bool = false
    
    // Count how many times heaven animation was played
    @State var countVisitsToHeaven: Int = 0
    
    // Property that controls if heaven animation is currently being played
    @State var isInHeaven: Bool = false
    
    // Adjust amount of coins on start
    let amountOfCoinsOnStart: Int = 2
    
    // Animated property that hides coins on the start
    @State var showingCoins: Bool = false
    
    // Property that controls if transition to the scene is currently in progress
    @State var hasStartedSwitchingToScene: Bool = false
    
    // Property that performs slots rotation
    @State var rotateSlots: Bool = false
    
    // Property that controls if arrow hint should be shown
    @State var shouldShowArrowAgain: Bool = true
    
    // Property that controls if gambling winning lights are shown
    @State var lightsBlinking: Bool = true
    
    // Property that controls if gambling winning lights are shown
    @State var showingBlinkingLights: Bool = false
    
    // Property for holding Geometry Proxy
    @State var geometryHolder: GeometryProxy?
    
    // Showing coins prize in the machine
    @State var showingReward: Bool = false
    
    // Property that controls if coin was inserted before hint was displayed
    @State var isCoinInsertedEarly: Bool = false
    
    // Property that controls if hand animation should be played
    @State var shouldAnimateHandHint: Bool = true
    
    // Property that controls if hand animation should be shown
    @State var showingHandHint: Bool = false
    
    var body: some View {
        ZStack{
            
            // Adjust Geometry Proxy
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        geometryHolder = geometry
                    }
            }
            
            LayerMixingManager(darkSlider: $darkSlider, heavenSlider: $heavenSlider)
            
            ZStack{
                // Arrow hint
                Image("gambling_hint")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: .black.opacity(0.4), radius: 25)
                    .opacity(isCoinInsertedEarly ? 1 : 0)
                
                // Handle of the gambling machine
                AnimatedHandle(isCoinInserted: $isCoinInsertedInMachine, isCoinInsertedEarly: $isCoinInsertedEarly, handleResult: handleResult, handleNoCoin: {})
                    .frame(height: 100)
                    .offset(x: 160, y: -45)
                
                // Base of the gambling machine
                Image("gambling_base")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(
                        SlotsRotation(rotateSlotsState: $rotateSlots)
                            .offset(y: 10)
                            .frame(width: 170)
                            .mask(
                                Rectangle()
                                    .frame(height: 60)
                                    .offset(y: 15)
                            )
                    )
                    .overlay(){
                        Image("gambling_overlay")
                            .interpolation(.high)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .allowsHitTesting(false)
                
                // Shoing blinking light animation on win
                ZStack{
                    if showingBlinkingLights{
                        ZStack{
                            Image("gambling_lights_1")
                                .interpolation(.high)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .glow(color: Color("MainYellow").opacity(0.4), radius: 10)
                                .opacity(lightsBlinking ? 1 : 0)
                            
                            Image("gambling_lights_2")
                                .interpolation(.high)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .glow(color: Color("MainYellow").opacity(0.4), radius: 10)
                                .opacity(lightsBlinking ? 0 : 1)
                        }
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
                                lightsBlinking.toggle()
                            }
                        }
                    }
                }
                .opacity(showingBlinkingLights ? 1 : 0)
                .allowsHitTesting(false)
                
                Image("gambling_reward_overlay")
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .glow(color: Color("MainYellow").opacity(0.2), radius: 10)
                    .allowsHitTesting(false)
                    .opacity(showingReward ? 1 : 0)
                    .onChange(of: showingBlinkingLights){
                        if showingReward == false{
                            withAnimation(.easeInOut(duration: 0.25)){
                                showingReward = true
                            }
                        }
                    }
                
            }
            .frame(height: 350)
            
            VStack {
                HStack {
                    Spacer()
                    
                    // Spawn drag and drop coins
                    if showingCoins{
                        VStack {
                            ForEach(0..<amountOfCoinsOnStart, id: \.self) { index in
                                DraggableCoin(isCoinInsertedInMachine: $isCoinInsertedInMachine, isInHeaven: $isInHeaven, insertCoin: insertCoin, geometryHolder: $geometryHolder, selectedStyle: index)
                                    .environmentObject(notificationManager)
                            }
                        }
                        .padding()
                        .transition(.move(edge: .trailing))
                    }
                    
                }
                Spacer()
            }
            .onChange(of: notificationManager.isTextPrintFinished){
                if (notificationManager.isTextPrintFinished == true && countVisitsToHeaven==0){
                    withAnimation(Animation.easeInOut(duration: 1.0)){
                        showingCoins = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        withAnimation(Animation.easeInOut(duration: 1.0)){
                            showingHandHint = true
                        }
                        
                        withAnimation(Animation.easeInOut(duration: 3.0).repeatForever()) {
                            shouldAnimateHandHint.toggle()
                        }
                    }
                }
            }
            
            // Call notification after transition is complete
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + TransitionManager().transitionDuration) {
                    notificationManager.callNotification(ID: 10)
                }
            }
            
            GeometryReader(){ proxy in
                let imageSize: CGFloat = 100
                
                Image("SF_finger_point")
                    .interpolation(.high)
                    .resizable()
                    .allowsHitTesting(false)
                    .shadow(color: .black.opacity(0.25), radius: 25)
                    .frame(width: imageSize, height: imageSize)
                    .rotationEffect(Angle(degrees: shouldAnimateHandHint ? -15 : 0))
                    .offset(
                        x: shouldAnimateHandHint ? (proxy.size.width/1.3) : (proxy.size.width - imageSize),
                        y: shouldAnimateHandHint ?  (proxy.size.height/5) : (0)
                    )
                    .opacity(showingCoins ? 1 : 0)
                    .opacity(shouldShowArrowAgain ? 1 : 0)
                    .opacity(showingHandHint ? 1 : 0)
            }
            .padding(.all, 50)
            
        }
    }
    
    // Function that is being performed after coin was inserted
    func insertCoin() {
        if !isCoinInsertedInMachine{
            // Play sound effect
            playSound(name: "Insert_Coin", ext: "mp3")
            
            withAnimation(.easeInOut) {
                isCoinInsertedInMachine = true
            }
            
            withAnimation(.easeInOut(duration: 1.0)) {
                isCoinInsertedEarly = true
            }
            
            withAnimation(.easeInOut) {
                shouldShowArrowAgain = false
            }
            
            withAnimation(.easeInOut){
                showingBlinkingLights = false
            }
            
            // Close notification
            notificationManager.closeNotification()
        }
    }
    
    // Handle results of the gambling slots rotation
    func handleResult(){
        // Adjust values for each "going to heaven" animations
        // For example first of all, the heaven background will go to 0.25, at the same time at the peak of the animation, the value of the dark background will be changed to a new one
        let heavenValues: [(Double, Double)] = [
            // Heaven value, Dark value
            (0.85, 0.4),
            (0.85, 0.5),
        ]
        
        if countVisitsToHeaven<1{
            // case win
            isInHeaven = true
            rotateSlots.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + SlotsRotation(rotateSlotsState: .constant(false)).animationDuration) {
                
                if let geometryHolder = geometryHolder {
                    if let centerOfTheScreen = GlobalPositionUtility.getGlobalPosition(view: geometryHolder) {
                        ParticleView.spawnParticle(xpos: Double(centerOfTheScreen.x), ypos: Double(centerOfTheScreen.y))
                    }
                }
                
                withAnimation(.easeInOut){
                    showingBlinkingLights = true
                }
                
                let tuple = heavenValues[countVisitsToHeaven]
                goToHeaven(heavenSliderGoal: tuple.0, darkSliderAfterwards: tuple.1)
                countVisitsToHeaven+=1
                
            }
        }
        else{
            // case loose
            
            rotateSlots.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + SlotsRotation(rotateSlotsState: .constant(false)).animationDuration) {
                
                withAnimation(.easeInOut(duration: 0.25)){
                    showingReward = false
                }
                
                notificationManager.callNotification(ID: 12, arrowAction: {
                    transitionManagerObservable.transitionToScene?(8)
                })
            }
        }
    }
    
    // Function that controls animation of going to heaven
    func goToHeaven(heavenSliderGoal: Double?, darkSliderAfterwards: Double?){
        let animationDuration = 2.5
        
        // Play sound effects
        playSound(name: "heaven_gambling", ext: "mp3")
        
        withAnimation(.easeInOut(duration: animationDuration)) {
            heavenSlider = heavenSliderGoal ?? 1.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            if countVisitsToHeaven == 1{
                notificationManager.callNotification(ID: 11)
            }
            
            withAnimation(.easeInOut(duration: 0.5)) {
                darkSlider = darkSliderAfterwards ?? darkSlider
            }
            
            withAnimation(.easeInOut(duration: animationDuration)) {
                heavenSlider = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration){
                // handle end of visit to heaven
                
                isInHeaven = false
            }
        }
    }
}

#Preview{
    LayersManager(initialView: GamblingScene())
}
