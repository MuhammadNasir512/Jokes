import SwiftUI

@main
struct JokesApp: App {
    var body: some Scene {
        WindowGroup {
            let apiHandler = APIHandler()
            let viewModel = JokesListView.ViewModel(apiHandler: apiHandler)
            JokesListView(viewModel: viewModel)
        }
    }
}
