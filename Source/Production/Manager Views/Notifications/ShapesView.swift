//
//
//
//
//
//

import SwiftUI


// Text bubble shape that describes the path of the shape
struct BubbleShape: Shape {
    
    // Radius of corners
    private let radius: CGFloat = 25
    
    // The size of the tail of the bubble
    private let tailSize: CGFloat = 10
    
    // Property that describes how far the tail stands out
    var trailProgress: CGFloat = 0

    // Animated property of the tail progress
    var animatableData: CGFloat {
        get { trailProgress }
        set { trailProgress = newValue }
    }

    // Path of the shape
    func path(in rect: CGRect) -> Path {
        let currentTrailSize = tailSize * trailProgress
        return Path { path in
            
            // Move to the initial position
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY - radius))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - rect.height / 2 + currentTrailSize))
            
            // Draw Tail curve
            path.addCurve(
                to: CGPoint(x: rect.minX, y: rect.maxY - rect.height / 2 - currentTrailSize),
                control1: CGPoint(x: rect.minX - currentTrailSize*2, y: rect.maxY - rect.height / 2 ),
                control2: CGPoint(x: rect.minX, y: rect.maxY - rect.height / 2 - currentTrailSize / 2 )
            )
            
            // Left up corner
            path.addArc(
                center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                radius: radius,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 270),
                clockwise: false
            )
            
            // Right up corner
            path.addArc(
                center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                radius: radius,
                startAngle: Angle(degrees: 270),
                endAngle: Angle(degrees: 0),
                clockwise: false
            )
            
            // Right bottom corner
            path.addArc(
                center: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius),
                radius: radius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 90),
                clockwise: false
            )
            
            // Left bottom corner
            path.addArc(
                center: CGPoint(x: rect.minX + radius, y: rect.maxY - radius),
                radius: radius,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 180),
                clockwise: false
            )
            
        }
    }
}

// View for debugging and testing Bubble Shape
struct DebugShape: View {
    
    @State var showingTrail: Bool = true
    
    var body: some View {
        VStack {
            BubbleShape(trailProgress: showingTrail ? 1 : 0)
                .frame(width: 300, height: 200)
                .foregroundColor(Color.red)
            
            Button("Button") {
                withAnimation(){
                    showingTrail.toggle()
                }
            }
        }
    }
}

#Preview {
    DebugShape()
}
