import XCTest
@testable import Jokes

final class JokesListViewModelTests: XCTestCase {

    func testSuccessfulLoadingOfJokes() throws {
        // Given
        let exp = XCTestExpectation(description: "Expectation1")
        let apiHandler = MockAPIHandler(urlString: "http:\\DummyUrlString.json")
        apiHandler.exp = exp
        let sut = JokesListView.ViewModel(apiHandler: apiHandler)
        
        // When
        sut.loadJokes()
        wait(for: [exp], timeout: 1)
        
        // Then
        XCTAssertEqual(sut.jokeCellModels.count, 12)
    }

    func testSuccessfulCreationOfCellModels() throws {
        // Given
        let exp = XCTestExpectation(description: "Expectation1")
        let apiHandler = MockAPIHandler(urlString: "http:\\DummyUrlString.json")
        apiHandler.exp = exp
        let sut = JokesListView.ViewModel(apiHandler: apiHandler)
        
        // When
        sut.loadJokes()
        wait(for: [exp], timeout: 1)
        let cellModels = sut.jokeCellModels
        
        guard let firstCellModel = cellModels.first else {
            XCTFail("There should be 12 models")
            return
        }
        // Then
        XCTAssertEqual(firstCellModel.id, 348)
        XCTAssertEqual(firstCellModel.joke, "There?s an order to the universe: space, time, Chuck Norris.... Just kidding, Chuck Norris is first.")
    }

    func testWhenAPIFailedThenItHasError() throws {
        // Given
        let exp = XCTestExpectation(description: "Expectation1")
        let apiHandler = MockAPIHandler(urlString: "http:\\DummyUrlString.json")
        apiHandler.fileNameInBundle = "DummyNonExistingFileName"
        apiHandler.exp = exp
        let sut = JokesListView.ViewModel(apiHandler: apiHandler)
        
        // When
        sut.loadJokes()
        wait(for: [exp], timeout: 1)
        let cellModels = sut.jokeCellModels
        XCTAssertEqual(cellModels.count, 0)

        guard let error = sut.error else {
            XCTFail("There should be non nil error")
            return
        }
        // Then
        XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (TestingErrorCase error 999.)")
    }
}
