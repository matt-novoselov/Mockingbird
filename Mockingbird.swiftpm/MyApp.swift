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
                
                Exp12_left_up_corner()
            }
            .preferredColorScheme(.light)
            .statusBar(hidden: true)
            .persistentSystemOverlays(.hidden)
        }
    }
}
