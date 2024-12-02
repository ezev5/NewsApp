//
//  GetNewsUseCase.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 29/11/2024.
//

import Foundation
import Combine

protocol GetNewsUseCaseProtocol {
  func execute() -> AnyPublisher<[Post], Error>
}

final class GetNewsUseCase: GetNewsUseCaseProtocol {
  private let repository: NewRepositoryProtocol
  
  init(repository: NewRepositoryProtocol) {
    self.repository = repository
  }
  
  func execute() -> AnyPublisher<[Post], Error> {
    return repository.getNewsRequest().eraseToAnyPublisher()
  }
}
