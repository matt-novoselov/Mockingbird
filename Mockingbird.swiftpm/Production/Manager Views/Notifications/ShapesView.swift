import SwiftUI

struct BubbleShape: Shape {
    private let radius: CGFloat
    private let tailSize: CGFloat
    var trailProgress: CGFloat

    init(radius: CGFloat = 25, trailProgress: CGFloat = 0) {
        self.radius = radius
        self.tailSize = 10
        self.trailProgress = trailProgress
    }

    var animatableData: CGFloat {
        get { trailProgress }
        set { trailProgress = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let currentTrailSize = tailSize * trailProgress
        return Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY - radius))
            
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - rect.height / 2 + currentTrailSize))
            path.addCurve(
                to: CGPoint(x: rect.minX, y: rect.maxY - rect.height / 2 - currentTrailSize),
                control1: CGPoint(x: rect.minX - currentTrailSize*2, y: rect.maxY - rect.height / 2 ),
                control2: CGPoint(x: rect.minX, y: rect.maxY - rect.height / 2 - currentTrailSize / 2 )
            )
            
            path.addArc(
                center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                radius: radius,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 270),
                clockwise: false
            )
            path.addArc(
                center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                radius: radius,
                startAngle: Angle(degrees: 270),
                endAngle: Angle(degrees: 0),
                clockwise: false
            )
            path.addArc(
                center: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius),
                radius: radius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 90),
                clockwise: false
            )
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
