//
//  SwiftUIView.swift
//
//
//  Created by Matt Novoselov on 18/01/24.
//

import SwiftUI

struct Exp16_drag_view: View {
    @State var isCoinInsertedInMachine: Bool = false

    var body: some View {
        let rectCollider = createMachineCollider(height: 200, width: 200)
        
        ZStack{
            MachineCollider(rectCollider: rectCollider)
                .foregroundColor(isCoinInsertedInMachine ? Color.yellow : Color.green)
            
            VStack {
                HStack {
                    Spacer()
                    
                    VStack {
                        ForEach(0..<6) { _ in
                            DraggableCoin(insertCoin: insertCoin, rectCollider: rectCollider)
                        }
                        
                        Button("Dispose Coin") {
                            isCoinInsertedInMachine = false
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
                print("coin has collided and slot is empty")
            }
        }
    }
}

#Preview{
    Exp16_drag_view()
}
