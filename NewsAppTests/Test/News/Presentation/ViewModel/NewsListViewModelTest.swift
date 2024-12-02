//
//  NewsListViewModelTest.swift
//  NewsAppTests
//
//  Created by Ezequiel Nicolas Velez on 02/12/2024.
//

import XCTest
import Combine
@testable import NewsApp

final class NewsListViewModelTest: XCTestCase {
  var useCase: MockGetNewsUseCase!
  var sut: NewsListViewModel!
  var cancellables: Set<AnyCancellable> = []
  
  override func setUp() {
    super.setUp()
    useCase = MockGetNewsUseCase()
    sut = NewsListViewModel(useCase: useCase)
  }
  
  override func tearDown() {
    useCase = nil
    sut = nil
    cancellables.removeAll()
    super.tearDown()
  }
  
  func testLoadDataSucces() {
    let expectation = expectation(description: "Load Data Finish")
    sut.$isLoading.sink { isLoading in
      if !isLoading {
        expectation.fulfill()
      }
    }.store(in: &cancellables)
    
    sut.loadData()
    waitForExpectations(timeout: 5)
    let result: [Post] = sut.searchResult
    
    XCTAssertFalse(result.isEmpty)
    XCTAssertEqual(result.count, 3)
  }
  
  func testFilterNewsByTitle() {
    let expectation = expectation(description: "Load Data Finish")
    sut.$isLoading.sink { isLoading in
      if !isLoading {
        expectation.fulfill()
      }
    }.store(in: &cancellables)
    
    sut.loadData()
    waitForExpectations(timeout: 5)
    
    let expectedResult: [Post] = [
      Post(
        userId: 1,
        id: 1,
        title: "Mock Title1 searchTest1",
        content: "Some mock content text, searchTest3",
        image: "https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        thumbnail: "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        publishedAt: "02/12/2024 13:25:21"
      )
    ]
    let inputString: String = "searchTest1"
    sut.filterNews(by: inputString)
    
    let result: [Post] = sut.searchResult
    
    XCTAssertFalse(result.isEmpty)
    XCTAssertEqual(result.count, 1)
    XCTAssertEqual(result.first, expectedResult.first)
  }
  
  func testFilterNewsByContent() {
    let expectation = expectation(description: "Load Data Finish")
    sut.$isLoading.sink { isLoading in
      if !isLoading {
        expectation.fulfill()
      }
    }.store(in: &cancellables)
    
    sut.loadData()
    waitForExpectations(timeout: 5)
    
    let expectedResult: [Post] = [
      Post(
        userId: 2,
        id: 2,
        title: "Mock Title2 searchTest3",
        content: "Some mock content text 2, searchTest2",
        image: "https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        thumbnail: "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        publishedAt: "02/12/2024 13:25:21"
      ),
      Post(
        userId: 3,
        id: 3,
        title: "Mock Title3",
        content: "Some mock content text 3, searchTest2",
        image: "https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        thumbnail: "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        publishedAt: "02/12/2024 13:25:21"
      )
    ]
    let inputString: String = "searchTest2"
    sut.filterNews(by: inputString)
    
    let result: [Post] = sut.searchResult
    
    XCTAssertFalse(result.isEmpty)
    XCTAssertEqual(result.count, 2)
    XCTAssertEqual(result.first, expectedResult.first)
    XCTAssertEqual(result.last, expectedResult.last)
  }
  
  func testFilterNewsByTitleAndContent() {
    let expectation = expectation(description: "Load Data Finish")
    sut.$isLoading.sink { isLoading in
      if !isLoading {
        expectation.fulfill()
      }
    }.store(in: &cancellables)
    
    sut.loadData()
    waitForExpectations(timeout: 5)
    
    let expectedResult: [Post] = [
      Post(
        userId: 1,
        id: 1,
        title: "Mock Title1 searchTest1",
        content: "Some mock content text, searchTest3",
        image: "https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        thumbnail: "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        publishedAt: "02/12/2024 13:25:21"
      ),
      Post(
        userId: 2,
        id: 2,
        title: "Mock Title2 searchTest3",
        content: "Some mock content text 2, searchTest2",
        image: "https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        thumbnail: "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        publishedAt: "02/12/2024 13:25:21"
      )
    ]
    let inputString: String = "searchTest3"
    sut.filterNews(by: inputString)
    
    let result: [Post] = sut.searchResult
    
    XCTAssertFalse(result.isEmpty)
    XCTAssertEqual(result.count, 2)
    XCTAssertEqual(result.first, expectedResult.first)
    XCTAssertEqual(result.last, expectedResult.last)
  }
}

final class MockGetNewsUseCase: GetNewsUseCaseProtocol {
  var constants: Constants = Constants()
  
  func execute() -> AnyPublisher<[NewsApp.Post], Error> {
    return Just(constants.newsList)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
  
  struct Constants {
    var newsList: [Post] = [
      Post(
        userId: 1,
        id: 1,
        title: "Mock Title1 searchTest1",
        content: "Some mock content text, searchTest3",
        image: "https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        thumbnail: "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        publishedAt: "02/12/2024 13:25:21"
      ),
      Post(
        userId: 2,
        id: 2,
        title: "Mock Title2 searchTest3",
        content: "Some mock content text 2, searchTest2",
        image: "https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        thumbnail: "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        publishedAt: "02/12/2024 13:25:21"
      ),
      Post(
        userId: 3,
        id: 3,
        title: "Mock Title3",
        content: "Some mock content text 3, searchTest2",
        image: "https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        thumbnail: "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        publishedAt: "02/12/2024 13:25:21"
      )
    ]
  }
}
