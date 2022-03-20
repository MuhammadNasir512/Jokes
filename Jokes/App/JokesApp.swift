import SwiftUI

// http://api.icndb.com/jokes/random/12?exclude=[explicit]

@main
struct JokesApp: App {
    var body: some Scene {
        WindowGroup {
            JokesListView()
        }
    }
}
