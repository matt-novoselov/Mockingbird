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
    
    @State var isCoinInsertedInMachine: Bool = false

    var body: some View {
        let rectCollider = createMachineCollider(height: 200, width: 200)
        
        ZStack{
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            HStack (spacing: 0){
                DynamicMachineCollider(rectCollider: rectCollider)
                    .background(isCoinInsertedInMachine ? Color.yellow : Color.green)
                
                AnimatedHandle(isCoinInserted: $isCoinInsertedInMachine)
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    VStack {
                        ForEach(0..<6) { _ in
                            DraggableCoin(isCoinInsertedInMachine: $isCoinInsertedInMachine, insertCoin: insertCoin, rectCollider: rectCollider)
                        }
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
    
    func insertCoin() {
        if !isCoinInsertedInMachine{
            withAnimation(.easeInOut) {
                isCoinInsertedInMachine = true
            }
        }
    }
}

#Preview{
    LayersManager(initialView: GamblingScene())
}
