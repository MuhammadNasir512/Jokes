import XCTest
@testable import Jokes

final class MockAPIHandler: APIHandlerType {
    var urlString: String
    var fileNameInBundle = "MockedJokes"
    var exp: XCTestExpectation!
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func getData(completionHandler: @escaping (Result<Data, Error>) -> Void)  {
        if let path = Bundle(for: MockAPIHandler.self).path(forResource: fileNameInBundle, ofType: "json") {
            do { let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completionHandler(.success(data))
            } catch(let error) {
                completionHandler(.failure(error))
            }
            exp.fulfill()
        } else {
            let error = NSError(domain: "TestingErrorCase", code: 999, userInfo: nil) as Error
            completionHandler(.failure(error))
            exp.fulfill()
        }
    }
}
