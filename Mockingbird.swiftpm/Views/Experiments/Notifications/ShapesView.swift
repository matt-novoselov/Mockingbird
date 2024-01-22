import SwiftUI

struct BubbleShape: Shape {
    private let radius: CGFloat
    private let tailSize: CGFloat
    private var showingTrail: Bool

    init(radius: CGFloat = 25, showingTrail: Bool = false) {
        self.radius = radius
        self.tailSize = 20
        self.showingTrail = showingTrail
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY - radius))
            
            
            if showingTrail{
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - rect.height / 2))
                path.addCurve(
                    to: CGPoint(x: rect.minX, y: rect.maxY - rect.height / 2 - tailSize),
                    control1: CGPoint(x: rect.minX - tailSize, y: rect.maxY - rect.height / 2),
                    control2: CGPoint(x: rect.minX, y: rect.maxY - rect.height / 2 - tailSize / 2)
                )
            }
            
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


#Preview {
    ZStack{
        Color(.red)
            .ignoresSafeArea()
        
        BubbleShape(showingTrail: true)
            .frame(width: 300, height: 200)
            .foregroundColor(Color.white)
    }
}
