//
//  MainTabView.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 29/11/2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
      TabView {
        NewsWireFrame.getView()
          .tabItem {
            Label("News", systemImage: "newspaper")
          }
        UsersWireFrame.getView()
          .tabItem {
            Label("Users", systemImage: "person")
          }
      }
    }
}

#Preview {
  MainTabView()
}
