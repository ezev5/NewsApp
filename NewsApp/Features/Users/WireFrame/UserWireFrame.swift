//
//  UserWireFrame.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 01/12/2024.
//

import Foundation
import SwiftUI

final class UsersWireFrame {
  static func getView() -> some View {
    
    let remoteDataManager: UserRemoteDataManagerProtocol = UserRemoteDataManager()
    
    let repository: UserRepositoryProtocol = UserRepository(remoteDataManager: remoteDataManager)
    
    let useCase: GetUsersUseCaseProtocol = GetUsersUseCase(repository: repository)
    
    return UsersView(
      viewModel: UsersViewModel(
        useCase: useCase
      )
    )
  }
}
