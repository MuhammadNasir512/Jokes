import Foundation

extension JokesListView {
    
    final class ViewModel: ObservableObject {
        
        @Published var jokeCellModels = [JokesCellViewModel]()
        @Published var isLoading = false
        @Published var needsShowingErrorAlert = false
        @Published private(set) var error: Error? = nil
        private var jokesCount = 100

        private var apiHandler: APIHandlerType
        init(apiHandler: APIHandlerType) {
            self.apiHandler = apiHandler
            self.apiHandler.setCustomResultCount(jokesCount)
        }

        func loadJokes() {
            jokeCellModels.removeAll()
            isLoading = true
            apiHandler.getData { [weak self] result in
                switch result {
                case .failure(let error): self?.handleError(error: error)
                case .success(let data): self?.handleSuccess(data: data)
                }
                self?.isLoading = false
            }
        }
        
        private func handleSuccess(data: Data) {
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let rootObject = try decoder.decode(RootObject.self, from: data)
                let jokes = rootObject.value
                jokeCellModels = jokes.map { JokesCellViewModel(jokesModel: $0) }
            } catch let error as NSError {
                handleError(error: error)
            }
        }

        private func handleError(error: Error) {
            self.error = error
            needsShowingErrorAlert = true
        }
    }
}
