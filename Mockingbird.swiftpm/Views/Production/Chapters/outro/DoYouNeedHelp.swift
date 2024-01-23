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
        VStack{
            Text("Do you need help?")
            
            Spacer()
            
            HStack{
                Text("icon")
                
                Link("+1 855 648 7228", destination: URL(string: "tel://+18556487228")!)
                    .foregroundStyle(.black)
            }
            
            HStack{
                Text("icon")
                
                Link("+1 800 662 4357", destination: URL(string: "tel://+18006624357")!)
                    .foregroundStyle(.black)
            }
            
            HStack{
                Text("icon")
                
                Link("recovered.org", destination: URL(string: "https://recovered.org/")!)
                    .foregroundStyle(.black)
            }
            
            Spacer()
            
            Text("->")
        }
    }
}

#Preview {
    DoYouNeedHelp(transitionToScene: TransitionManager().transitionToScene)
}
