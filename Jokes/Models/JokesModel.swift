import Foundation

struct RootObject: Codable {
    let value: [JokesModel]
}
struct JokesModel: Codable {
    let id: Int
    let joke: String
}
