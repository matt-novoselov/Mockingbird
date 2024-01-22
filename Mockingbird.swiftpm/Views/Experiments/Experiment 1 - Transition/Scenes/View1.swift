//
//  View1.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI


struct View1: View {
    var transitionToScene: (Int) -> Void
    @State var screenWidth: CGFloat?
    @State var screenHeight: CGFloat?
    
    var body: some View {
//        ZStack{
//            Image("white_background")
//                .resizable()
//                .scaledToFill()
//            
//            Button("Show Next View") {
//                transitionToScene(1)
//            }
//            .foregroundColor(.green)
//            .buttonStyle(.borderedProminent)
//        }
        
        ZStack {
            GeometryReader { geometry in
                LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
                    .onAppear(){
                        screenWidth = geometry.size.width
                        screenHeight = geometry.size.height
                    }
            }
            
            VStack {
                            Button("Show Next View") {
                                transitionToScene(1)
                            }
                            .foregroundColor(.green)
                            .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: screenWidth,
                   maxHeight: screenHeight)
        }
        
    }
}

#Preview {
    View1(transitionToScene: TransitionManager().transitionToScene)
}
