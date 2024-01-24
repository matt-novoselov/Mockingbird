import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            Group{                
                LayersManager(initialView: TransitionManager())
            }
            .preferredColorScheme(.light)
            .statusBar(hidden: true)
            .persistentSystemOverlays(.hidden)
            .environmentObject(TransitionManagerObservable())
        }
    }
}
