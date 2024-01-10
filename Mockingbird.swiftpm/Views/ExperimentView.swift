//
//  FontModel.swift
//  Mockingbird
//
//  Created by Matt Novoselov on 27/12/23.
//

import SwiftUI

struct ExperimentView: View {
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var font: Font?
    
    var body: some View {
        ZStack{
            VStack{
                Group {
                    if orientation.isPortrait {
                        Text("Portrait")
                    } else if orientation.isLandscape {
                        Text("Landscape")
                    } else if orientation.isFlat {
                        Text("Flat")
                    } else {
                        Text("Unknown")
                    }
                }
                .onRotate { newOrientation in
                    orientation = newOrientation
                }
                
                Rectangle()
                    .fill(Color.MBgreenColor)
                    .frame(width: 200, height: 200)
                
                Image("Image1")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Text("Hello, world!")
                    .font(font)
                    .onAppear(){
                        font = getFont()
                    }
            }
            
            if orientation.isPortrait {
                PortraitModeBlockerView()
                    .onRotate { newOrientation in
                        orientation = newOrientation
                    }
            }
        }
    }
}

#Preview {
    ExperimentView()
}
