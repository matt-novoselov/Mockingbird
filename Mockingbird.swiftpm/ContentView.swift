import SwiftUI

struct ContentView: View {
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var font: Font?
    
    func getFont() {
        let cfURL = Bundle.main.url(forResource: "RedBurger", withExtension: "otf")! as CFURL
        
        print(cfURL)

        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)

        let uiFont = UIFont(name: "RED BURGER", size:  30.0)

        font = Font(uiFont ?? UIFont())
    }

    var body: some View {
        Text("Hello, world!")
            .font(font)
            .onAppear(){
                getFont()
            }
        
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
    }
}


// Our custom view modifier to track rotation and
// call our action
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
