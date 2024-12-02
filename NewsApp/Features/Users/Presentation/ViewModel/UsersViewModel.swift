//
//  UsersViewModel.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 01/12/2024.
//

import Foundation
import Combine

protocol UsersViewModelProtocol: ObservableObject {
  var users: [User] { get }
  var isLoading: Bool { get }
  var isMapVisible: Bool { get set }
  func loadData()
  func didTapUser(_ user: User)
  func getUser() -> User?
}

final class UsersViewModel: UsersViewModelProtocol {
  @Published var users: [User] = []
  @Published var isLoading: Bool = true
  @Published var isMapVisible: Bool = false
  private var useCase: GetUsersUseCaseProtocol
  private var cancellables: Set<AnyCancellable> = []
  private var selectedUser: User?
  
  init(useCase: GetUsersUseCaseProtocol) {
    self.useCase = useCase
  }
  
  func loadData() {
    useCase.execute().sink(
      receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          //TODO: handle errors
          print(error)
        case .finished:
          print("dowloaded")
        }
      },
      receiveValue: { [weak self] users in
        self?.users = users
        self?.isLoading = false
      }
    ).store(in: &cancellables)
  }
  
  func didTapUser(_ user: User) {
    selectedUser = user
    isMapVisible = true
  }
  
  func getUser() -> User? {
    return selectedUser
  }
}
