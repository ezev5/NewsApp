//
//  MockUsersrepository.swift
//  NewsAppTests
//
//  Created by Ezequiel Nicolas Velez on 02/12/2024.
//

import Foundation
import Combine
@testable import NewsApp

final class MockUsersrepository: UserRepositoryProtocol {
  var getUsersRequestCalled: Bool = false
  var simulateError: Bool = false
  var constants: Constants = Constants()
  
  func getUsersRequest() -> AnyPublisher<[NewsApp.User], Error> {
    getUsersRequestCalled = true
    
    guard !simulateError else {
      return Fail(
        error: NewsAppError.badURL
      )
      .eraseToAnyPublisher()
    }
    
    return Just(constants.userList)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
  
  struct Constants {
    var userList: [User] = [
      User(
        id: 1,
        firstname: "John",
        lastname: "Doe",
        email: "johndoe@example.com",
        birthDate: "1973-01-22",
        address: Address(
          street: "123 Main Street",
          suite: "Apt. 4",
          city: "Anytown",
          zipcode: "12345-6789",
          geo: Geo(
            lat: "42.1234",
            lng: "-71.2345"
          )
        )
      ),
      User(
        id: 2,
        firstname: "Test",
        lastname: "User",
        email: "testuser@example.com",
        birthDate: "1994-05-05",
        address: Address(
          street: "Las Heras",
          suite: "1035",
          city: "Tandil",
          zipcode: "7000",
          geo: Geo(
            lat: "37.3288",
            lng: "59.1367"
          )
        )
      )
    ]
  }
}
