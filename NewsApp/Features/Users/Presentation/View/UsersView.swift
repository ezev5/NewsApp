//
//  UsersView.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 01/12/2024.
//

import SwiftUI

struct UsersView<ViewModel: UsersViewModelProtocol>: View {
  @StateObject var viewModel: ViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        if viewModel.isLoading {
          ProgressView()
            .tint(.accentColor)
        } else {
          List(viewModel.users, id: \.id) { user in
            UserListRowView(
              user: user,
              action: {
                viewModel.didTapUser(user)
              }
            )
          }
        }
      }
      .navigationTitle("Users")
    }
    .onAppear {
      viewModel.loadData()
    }
    .fullScreenCover(isPresented: $viewModel.isMapVisible) {
      MapView(isMapVisible: $viewModel.isMapVisible, user: viewModel.getUser())
    }
  }
}

#Preview {
  UsersWireFrame.getView()
}
