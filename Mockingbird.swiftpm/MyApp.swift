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
                
                Exp16_drag_view()
            }
            .preferredColorScheme(.light)
            .statusBar(hidden: true)
            .persistentSystemOverlays(.hidden)
        }
    }
}
