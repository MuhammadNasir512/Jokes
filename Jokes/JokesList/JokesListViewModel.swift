import Foundation

extension JokesListView {
    
    final class ViewModel: ObservableObject {
        private var apiHandler: APIHandlerType
        @Published var isLoading = false
        @Published var jokeCellModels = [JokesCellViewModel]()

        init(apiHandler: APIHandlerType) {
            self.apiHandler = apiHandler
        }

        func loadJokes() {
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
            // Show error
        }
    }
}
