import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            Group{
                //            ZStack{
                //                ContentView()
                //                PortraitModeBlockerView()
                //            }
                
                ContentView()
            }
            .preferredColorScheme(.light)
            .statusBar(hidden: true)
            .persistentSystemOverlays(.hidden)
        }
    }
}
