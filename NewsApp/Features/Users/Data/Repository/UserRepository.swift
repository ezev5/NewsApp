//
//  UserRepository.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 01/12/2024.
//

import Foundation
import Combine

protocol UserRepositoryProtocol {
  func getUsersRequest()  -> AnyPublisher<[User], Error>
}

final class UserRepository: UserRepositoryProtocol {
  private let remoteDataManager: UserRemoteDataManagerProtocol
  
  init(remoteDataManager: UserRemoteDataManagerProtocol) {
    self.remoteDataManager = remoteDataManager
  }
  
  func getUsersRequest()  -> AnyPublisher<[User], Error> {
    return remoteDataManager.fetchUsers().eraseToAnyPublisher()
  }
}
