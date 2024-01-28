import SwiftUI

struct Exp24_LogicalScreenResolution: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Screen Resolution:")
                Text(getScreenResolution(from: geometry.size))
                
                Rectangle()
                    .frame(width: 100, height: 100)
                    .position(CGPoint(x: 1366-50, y: 1024-50))
            }
        }
    }

    func getScreenResolution(from size: CGSize) -> String {
        let width = size.width
        let height = size.height

        return "\(width) x \(height)"
    }
}

#Preview {
    Exp24_LogicalScreenResolution()
}

