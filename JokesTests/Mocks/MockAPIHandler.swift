import XCTest
@testable import Jokes

final class MockAPIHandler: APIHandlerType {
    
    let urlString: String
    var exp: XCTestExpectation!
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func getData(completionHandler: @escaping (Result<Data, Error>) -> Void)  {
        if let path = Bundle(for: MockAPIHandler.self).path(forResource: "MockedJokes", ofType: "json") {
            do { let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completionHandler(.success(data))
                self.exp.fulfill()
            } catch(let error) {
                completionHandler(.failure(error))
            }
        }
    }
}
