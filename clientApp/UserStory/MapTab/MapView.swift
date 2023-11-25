//
//  MapView.swift
//  TestGarbage
//
//  Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import MapKit
import SwiftUI

var mockAnnotations = [
  Place(name: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
  Place(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
  Place(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
  Place(name: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
]

struct MapView: View {
  enum ActiveSheet: String, Identifiable {
    case details
    case creation
    var id: String {
      rawValue
    }
  }
  @State private var selectedPlace: Place?
  @State private var activeSheet: ActiveSheet?
  
  var places: [Place]
  
  @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
  
  private func makeAnnotation(place: Place) -> Annotation<some View, some View>  {
    Annotation("123", coordinate: place.coordinate) {
      Circle()
        .strokeBorder(.red, lineWidth: 4)
        .frame(width: 20, height: 20)
        .highPriorityGesture(
          TapGesture().onEnded {
            selectedPlace = place
              Task {
                try await Task.sleep(nanoseconds: (1 * NSEC_PER_SEC))
                activeSheet = .details
              }
          }
        )
    }
  }
  
  var body: some View {
    ZStack{
      MapReader { reader in
        Map(position: $position) {
          ForEach(places, id: \.id) { place in
            makeAnnotation(place: place)
          }
        }
        .onTapGesture { location in
          guard let pinLocation = reader.convert(location, from: .local) else { return }
            Task { @MainActor in
              selectedPlace = Place(name: "", coordinate: pinLocation)
              activeSheet = .creation
            }
        }
        .sheet(item: $activeSheet) { item in
          if let selectedPlace = selectedPlace {
            switch item {
            case .creation:
              NavigationView {
                CreateGarbageTagView()
              }
            case .details:
              NavigationView {
                GarbageDetails(place: selectedPlace)
              }
            }
          } else {
              Text("Internal error, try again!!!")
          }
        }

      }
      HeaderView()
    }
  }
}
