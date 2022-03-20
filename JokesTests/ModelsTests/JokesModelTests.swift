import XCTest
@testable import Jokes

final class JokesModelTests: XCTestCase {
    
    func testJokesDecodedToModel() throws {
        let jokes = makeJokesModels()
        let expectedValue = 12
        let actualValue = jokes.count
        XCTAssertEqual(actualValue, expectedValue)
        
        let firstJoke = jokes.first!
        XCTAssertEqual(firstJoke.id, 348)
        XCTAssertEqual(firstJoke.joke, "There?s an order to the universe: space, time, Chuck Norris.... Just kidding, Chuck Norris is first.")
    }

    private func makeJokesModels() -> [JokesModel] {
        let data = mockedJsonData()!
        let decoder = JSONDecoder()
        let jokesModel = try! decoder.decode(RootObject.self, from: data)
        return jokesModel.value
    }
    
    private func mockedJsonData() -> Data? {
        guard let path = Bundle(for: JokesModelTests.self).path(forResource: "MockedJokes", ofType: "json") else { return nil }
        do { let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch { }
        return nil
    }
}
