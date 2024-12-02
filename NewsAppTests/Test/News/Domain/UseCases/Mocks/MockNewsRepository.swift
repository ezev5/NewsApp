//
//  MockNewsRepository.swift
//  NewsAppTests
//
//  Created by Ezequiel Nicolas Velez on 02/12/2024.
//

import Foundation
import Combine
@testable import NewsApp

final class MockNewsRepository: NewRepositoryProtocol {
  var getNewsRequestCalled: Bool = false
  var simulateError: Bool = false
  var constants: Constants = Constants()
  
  func getNewsRequest() -> AnyPublisher<[NewsApp.Post], Error> {
    getNewsRequestCalled = true

    guard !simulateError else {
      return Fail(
        error: NewsAppError.badURL
      )
      .eraseToAnyPublisher()
    }
    
    return Just(constants.newsList)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
  
  struct Constants {
    var newsList: [Post] = [
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
  }

}
