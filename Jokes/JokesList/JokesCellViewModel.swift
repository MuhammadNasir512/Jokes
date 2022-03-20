
struct JokesCellViewModel: Identifiable {
    let id: Int
    let joke: String
}

extension JokesCellViewModel {
    init(jokesModel: JokesModel) {
        id = jokesModel.id
        joke = jokesModel.joke
    }
}
