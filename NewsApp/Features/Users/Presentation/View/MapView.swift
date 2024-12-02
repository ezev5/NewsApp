//
//  MapView.swift
//  NewsApp
//
//  Created by Ezequiel Nicolas Velez on 01/12/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
  @Binding var isMapVisible: Bool
  var user: User?
  
  var body: some View {
    ZStack {
      Map(initialPosition: position) {
        if let user: User = user {
          Marker(
            user.displayableName,
            systemImage: "person.fill",
            coordinate: coordinates
          )
        }
      }
      VStack {
        HStack {
          Button(action: {
            isMapVisible = false
          }) {
            Image(systemName: "xmark.circle.fill")
                 .foregroundStyle(Color.secondary)
                 .font(.system(size: 40))
                 .padding(4)
          }
          Spacer()
        }
        Spacer()
      }
    }
  }
  
  var position: MapCameraPosition {
    MapCameraPosition.region(
        MKCoordinateRegion(
            center: coordinates,
            span: MKCoordinateSpan(
              latitudeDelta: 1,
              longitudeDelta: 1
            )
        )
    )
  }
  
  var coordinates: CLLocationCoordinate2D {
    CLLocationCoordinate2D(
      latitude: Double(user?.address.geo.lat ?? "") ?? .zero,
      longitude: Double(user?.address.geo.lng ?? "") ?? .zero
    )
  }
}

#Preview {
  MapView(
    isMapVisible: .constant(true), 
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
    )
  )
}
