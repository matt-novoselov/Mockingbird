import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {

            ZStack{
                ContentView()
                PortraitModeBlockerView()
            }
            .preferredColorScheme(.light)
        }
    }
}
