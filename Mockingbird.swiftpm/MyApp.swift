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
                
                Exp18_dynamic_resize()
            }
            .preferredColorScheme(.light)
            .statusBar(hidden: true)
            .persistentSystemOverlays(.hidden)
        }
    }
}
