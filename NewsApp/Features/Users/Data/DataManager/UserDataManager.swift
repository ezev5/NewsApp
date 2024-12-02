//
//  UserDataManager.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 01/12/2024.
//

import Foundation
import Combine

protocol UserRemoteDataManagerProtocol {
  func fetchUsers() -> AnyPublisher<[User], Error>
}

final class UserRemoteDataManager: UserRemoteDataManagerProtocol {
  func fetchUsers() -> AnyPublisher<[User], Error> {
    guard let url: URL = URL(string: Endpoint.usersURL) else {
      return Fail(error: NewsAppError.badURL).eraseToAnyPublisher()
    }
    let request: URLRequest = URLRequest(url: url)
    return NetworkingManager.download(request: request)
      .decode(type: [User].self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}
