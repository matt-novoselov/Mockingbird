//
//  SwiftUIView.swift
//  
//
//  Created by Matt Novoselov on 22/01/24.
//

import SwiftUI

struct Exp23_ArrangeProblem: View {
    var body: some View {
        OverlayView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background { /// here!
                Image("PH_grid")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            }
    }
}

struct OverlayView: View {
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            
            Spacer()
        }
    }
}

#Preview {
    Exp23_ArrangeProblem()
}
