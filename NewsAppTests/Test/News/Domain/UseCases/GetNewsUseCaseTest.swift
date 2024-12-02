//
//  GetNewsUseCaseTest.swift
//  NewsAppTests
//
//  Created by Ezequiel Nicolas Velez on 02/12/2024.
//

import XCTest
import Combine
@testable import NewsApp

final class GetNewsUseCaseTest: XCTestCase {
  private var repository: MockNewsRepository!
  private var sut: GetNewsUseCase!
  private var cancellables: Set<AnyCancellable> = []
  
  override func setUp() {
    super.setUp()
    repository = MockNewsRepository()
    sut = GetNewsUseCase(repository: repository)
  }
  
  override func tearDown() {
    sut = nil
    repository = nil
    cancellables.removeAll()
    super.tearDown()
  }
  
  func testGetNewsSuccess() throws {
    let didGetNews: XCTestExpectation = XCTestExpectation()
    let expectedResult: [Post] = [
      Post(
        userId: 1,
        id: 1,
        title: "Mock Title 1",
        content: "Some mock content text",
        image: "https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        thumbnail: "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        publishedAt: "02/12/2024 13:25:21"
      ),
      Post(
        userId: 2,
        id: 2,
        title: "Mock Title 2",
        content: "Some mock content text 2",
        image: "https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        thumbnail: "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        publishedAt: "02/12/2024 13:25:21"
      ),
      Post(
        userId: 3,
        id: 3,
        title: "Mock Title 3",
        content: "Some mock content text 3",
        image: "https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        thumbnail: "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
        publishedAt: "02/12/2024 13:25:21"
      )
    ]

    var unsafeNews: [Post]?
    repository.getNewsRequestCalled = false

    // When
    sut.execute()
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished:
            didGetNews.fulfill()
          case .failure(let error):
            XCTFail("Execute failed with error: \(error)")
          }
        }, receiveValue: { response in
          unsafeNews = response
        }
      )
      .store(in: &cancellables)

    // Then
    wait(for: [didGetNews], timeout: 2.0)
    let safeNews: [Post] = try XCTUnwrap(unsafeNews)
    XCTAssertTrue(repository.getNewsRequestCalled)
    XCTAssertEqual(expectedResult.count, safeNews.count)
    XCTAssertEqual(expectedResult.first, safeNews.first)
  }
  
  func testGetNewsFails() {
    let didGetNewsFails: XCTestExpectation = XCTestExpectation()
    var unsafeError: Error?
    repository.getNewsRequestCalled = false
    repository.simulateError = true

    // When
    sut.execute()
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished:
            XCTFail("Execute finish")
          case .failure(let error):
            unsafeError = error
            didGetNewsFails.fulfill()
          }
        }, receiveValue: { _ in }
      )
      .store(in: &cancellables)

    // Then
    wait(for: [didGetNewsFails], timeout: 2.0)
    XCTAssertNotNil(unsafeError)
    XCTAssertTrue(repository.getNewsRequestCalled)
  }
}
