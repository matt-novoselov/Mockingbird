import SwiftUI

struct BubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        let bezierPath = UIBezierPath()

        bezierPath.move(to: CGPoint(x: width - 20, y: height))
        bezierPath.addLine(to: CGPoint(x: 15, y: height))
        bezierPath.addCurve(to: CGPoint(x: 0, y: height - 15), controlPoint1: CGPoint(x: 8, y: height), controlPoint2: CGPoint(x: 0, y: height - 8))
        bezierPath.addLine(to: CGPoint(x: 0, y: 15))
        bezierPath.addCurve(to: CGPoint(x: 15, y: 0), controlPoint1: CGPoint(x: 0, y: 8), controlPoint2: CGPoint(x: 8, y: 0))
        bezierPath.addLine(to: CGPoint(x: width - 20, y: 0))
        bezierPath.addCurve(to: CGPoint(x: width - 5, y: 15), controlPoint1: CGPoint(x: width - 12, y: 0), controlPoint2: CGPoint(x: width - 5, y: 8))
        bezierPath.addLine(to: CGPoint(x: width - 5, y: height - 12))
        bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 5, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
        bezierPath.addLine(to: CGPoint(x: width + 1, y: height))
        bezierPath.addCurve(to: CGPoint(x: width - 20, y: height), controlPoint1: CGPoint(x: width - 15, y: height), controlPoint2: CGPoint(x: width - 20, y: height))
        
        return Path(bezierPath.cgPath)
    }
}

#Preview {
        BubbleShape()
}
