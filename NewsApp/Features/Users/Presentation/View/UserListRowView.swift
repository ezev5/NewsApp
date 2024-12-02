//
//  UserListRowView.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 01/12/2024.
//

import SwiftUI

struct UserListRowView: View {
  var user: User
  var action: () -> Void

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(user.displayableName)
          .font(.title)
        Text(user.email)
          .font(.subheadline)
      }
      Spacer()
      Image(systemName: "map.fill")
        .font(.title)
        .padding(10)
        .foregroundStyle(.blue)
        .onTapGesture {
          action()
        }
    }
  }
}

#Preview {
  List {
    UserListRowView(
      user: User(
        id: 1,
        firstname: "John",
        lastname: "Doe",
        email: "johndoe@example.com",
        birthDate: "1973-01-22",
        address: Address(
          street: "123 Main Street",
          suite: "Apt. 4",
          city: "Anytown",
          zipcode: "12345-6789",
          geo: Geo(
            lat: "42.1234",
            lng: "-71.2345"
          )
        )
      ), 
      action: {}
    )
  }
  .listStyle(.plain)
}
