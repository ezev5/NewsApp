//
//  GetUsersUseCaseTest.swift
//  NewsAppTests
//
//  Created by Ezequiel Nicolas Velez on 02/12/2024.
//

import XCTest
import Combine
@testable import NewsApp

final class GetUsersUseCaseTest: XCTestCase {
  private var repository: MockUsersrepository!
  private var sut: GetUsersUseCase!
  private var cancellables: Set<AnyCancellable> = []
  
  override func setUp() {
    super.setUp()
    repository = MockUsersrepository()
    sut = GetUsersUseCase(repository: repository)
  }
  
  override func tearDown() {
    sut = nil
    repository = nil
    cancellables.removeAll()
    super.tearDown()
  }
  
  func testGetUsersSuccess() throws {
    let didGetUsers: XCTestExpectation = XCTestExpectation()
    let expectedResult: [User] = [
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

    var unsafeUsers: [User]?
    repository.getUsersRequestCalled = false

    // When
    sut.execute()
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished:
            didGetUsers.fulfill()
          case .failure(let error):
            XCTFail("Execute failed with error: \(error)")
          }
        }, receiveValue: { response in
          unsafeUsers = response
        }
      )
      .store(in: &cancellables)

    // Then
    wait(for: [didGetUsers], timeout: 2.0)
    let safeUsers: [User] = try XCTUnwrap(unsafeUsers)
    XCTAssertTrue(repository.getUsersRequestCalled)
    XCTAssertEqual(expectedResult.count, safeUsers.count)
    XCTAssertEqual(expectedResult.first, safeUsers.first)
  }
  
  func testGetUsersFails() {
    let didGetUsersFails: XCTestExpectation = XCTestExpectation()
    var unsafeError: Error?
    repository.getUsersRequestCalled = false
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
            didGetUsersFails.fulfill()
          }
        }, receiveValue: { _ in }
      )
      .store(in: &cancellables)

    // Then
    wait(for: [didGetUsersFails], timeout: 2.0)
    XCTAssertNotNil(unsafeError)
    XCTAssertTrue(repository.getUsersRequestCalled)
  }

}
