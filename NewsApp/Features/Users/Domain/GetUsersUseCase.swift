//
//  GetUsersUseCase.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 01/12/2024.
//

import Foundation
import Combine

protocol GetUsersUseCaseProtocol {
  func execute() -> AnyPublisher<[User], Error>
}

final class GetUsersUseCase: GetUsersUseCaseProtocol {
  private let repository: UserRepositoryProtocol
  
  init(repository: UserRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute() -> AnyPublisher<[User], Error> {
    return repository.getUsersRequest().eraseToAnyPublisher()
  }
}
