//
//  NewDataManager.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 29/11/2024.
//

import Foundation
import Combine

protocol NewRemoteDataManagerProtocol {
  func fetchNews() -> AnyPublisher<[Post], Error>
}

final class NewRemoteDataManager: NewRemoteDataManagerProtocol {
  func fetchNews() -> AnyPublisher<[Post], Error> {
    guard let url: URL = URL(string: Endpoint.postsURL) else {
      return Fail(error: NewsAppError.badURL).eraseToAnyPublisher()
    }
    let request: URLRequest = URLRequest(url: url)
    return NetworkingManager.download(request: request)
      .decode(type: [Post].self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}
