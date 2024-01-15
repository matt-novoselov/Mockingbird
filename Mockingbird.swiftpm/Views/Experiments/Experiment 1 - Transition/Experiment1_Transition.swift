//
//  Experiment 1 - Transition.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 15/01/24.
//

import SwiftUI

struct Experiment1_Transition: View {
    @State private var screenID: Int = 0
    
    var body: some View {
        
        switch screenID {
        case 0:
            ZStack{
                View1()
                
                Button("Press to show details") {
                    withAnimation {
                        screenID = 1;
                    }
                }
            }
            .transition(.move(edge: screenID==2 ? .top : .bottom))
            
        case 1:
            ZStack{
                View2()
                
                Button("Press to show details") {
                    withAnimation {
                        screenID = 2;
                    }
                }
            }
            .transition(.move(edge: screenID==0 ? .top : .bottom))
            
        case 2:
            ZStack{
                View3()
                
                Button("Press to show details") {
                    withAnimation {
                        screenID = 0;
                    }
                }
            }
            .transition(.move(edge: screenID==1 ? .top : .bottom))
            
        default:
            VStack{}
        }
    }
}

#Preview {
    Experiment1_Transition()
}
