//
//  Newrepository.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 29/11/2024.
//

import Foundation
import Combine

protocol NewRepositoryProtocol {
  func getNewsRequest() -> AnyPublisher<[Post], Error>
}

final class NewRepository: NewRepositoryProtocol {
  private let remoteDataManager: NewRemoteDataManagerProtocol
  
  init(remoteDataManager: NewRemoteDataManagerProtocol) {
    self.remoteDataManager = remoteDataManager
  }
  
  func getNewsRequest() -> AnyPublisher<[Post], Error> {
    return remoteDataManager.fetchNews().eraseToAnyPublisher()
  }
}
