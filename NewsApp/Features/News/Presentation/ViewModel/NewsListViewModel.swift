//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 29/11/2024.
//

import Foundation
import Combine

protocol NewsListViewModelProtocol: ObservableObject {
  var searchResult: [Post] { get }
  var searchInput: String { get set }
  var isLoading: Bool { get }
  func loadData()
}

final class NewsListViewModel: NewsListViewModelProtocol {
  @Published var searchResult: [Post] = []
  @Published var searchInput: String = ""
  @Published var isLoading: Bool = true
  private var news: [Post] = []
  private var useCase: GetNewsUseCaseProtocol
  private var cancellables: Set<AnyCancellable> = []
  
  init(useCase: GetNewsUseCaseProtocol) {
    self.useCase = useCase
    addSubscribers()
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
      receiveValue: { [weak self] posts in
        self?.news = posts
        self?.searchResult = posts
        self?.isLoading = false
      }
    ).store(in: &cancellables)
  }
  
  private func addSubscribers() {
    $searchInput
      .removeDuplicates()
      .sink { [weak self] text in
        self?.filterNews(by: text.lowercased())
      }.store(in: &self.cancellables)
  }
  
  func filterNews(by text: String) {
    guard !text.isEmpty else {
      searchResult = news
      return
    }
    searchResult = news.filter({ $0.title.contains(text) || $0.content.contains(text)})
  }
}
