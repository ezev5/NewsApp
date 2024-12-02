//
//  NewsWireFrame.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 29/11/2024.
//

import Foundation
import SwiftUI

final class NewsWireFrame {
  static func getView() -> some View {
    
    let remoteDataManager: NewRemoteDataManagerProtocol = NewRemoteDataManager()
    
    let repository: NewRepositoryProtocol = NewRepository(remoteDataManager: remoteDataManager)
    
    let useCase: GetNewsUseCaseProtocol = GetNewsUseCase(repository: repository)
    
    return NewsListView(
      viewModel:
        NewsListViewModel(
          useCase: useCase
        )
    )
  }
}
