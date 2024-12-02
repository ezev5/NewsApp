//
//  NewsListView.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 29/11/2024.
//

import SwiftUI

struct NewsListView<ViewModel: NewsListViewModelProtocol>: View {
  @StateObject var viewModel: ViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        if viewModel.isLoading {
          ProgressView()
            .tint(.accentColor)
        } else {
          if viewModel.searchResult.isEmpty {
            VStack {
              Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
              Text("No search results!")
                .font(.title)
            }
          } else {
            List(viewModel.searchResult, id: \.id) { post in
              NavigationLink(value: post) {
                NewsListRowView(
                  new: post
                )
              }
              .buttonStyle(.plain)
              .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationDestination(for: Post.self) { post in
              NewDetailView(new: post)
            }
          }
        }
      }
      .navigationTitle("News")
    }
    .searchable(text: $viewModel.searchInput, prompt: "filter")
    .onAppear {
      viewModel.loadData()
    }
  }
}

#Preview {
  NewsWireFrame.getView()
}
