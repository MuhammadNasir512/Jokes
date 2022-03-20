import SwiftUI

struct JokesListView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.jokeCellModels) { joke in
                Text(joke.joke).padding(.bottom).padding(.top)
            }
            .listStyle(.plain)
            .navigationTitle("Jokes")
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    loadJokes()
                }) {
                    Image(systemName: "arrow.clockwise").font(.title2)
                }
                .foregroundColor(.blue)
            })
        }
        .overlay(ProgressView().background(.white).opacity(viewModel.isLoading ? 1 : 0))
        .alert(isPresented: $viewModel.needsShowingErrorAlert) {
            Alert(title: Text(viewModel.error?.localizedDescription ?? "Unknown Error"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: loadJokes)
    }
    
    private func loadJokes() {
        viewModel.loadJokes()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let apiHandler = APIHandler()
        let viewModel = JokesListView.ViewModel(apiHandler: apiHandler)
        JokesListView(viewModel: viewModel)
    }
}
