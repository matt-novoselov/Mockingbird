//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 23/01/24.
//

import SwiftUI

struct DoYouNeedHelp: View {
    var transitionToScene: (Int) -> Void
    
    var body: some View {
        ZStack{
            LayerMixingManager(darkSlider: .constant(0), heavenSlider: .constant(0))
            
            VStack{
                FontText(text: "Do you need help?", size: 96)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 0){
                    HStack(spacing: 30){
                        Image("SF_phone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                        
                        Link("+1 855 648 7228", destination: URL(string: "tel://+18556487228")!)
                            .foregroundStyle(.black)
                            .font(getFont(size: 64))
                    }
                    
                    HStack(spacing: 30){
                        Image("SF_phone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                        
                        Link("+1 800 662 4357", destination: URL(string: "tel://+18006624357")!)
                            .foregroundStyle(.black)
                            .font(getFont(size: 64))
                    }
                    
                    HStack(spacing: 30){
                        Image("SF_globe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                        
                        Link("recovered.org", destination: URL(string: "https://recovered.org/")!)
                            .foregroundStyle(.black)
                            .font(getFont(size: 64))
                    }
                }
                
                Spacer()
                
                Button(action: {transitionToScene(15)}) {
                    Image("long_arrow_button")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    DoYouNeedHelp(transitionToScene: TransitionManager().transitionToScene)
}
