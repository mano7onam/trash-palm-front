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
  
  @State private var selectedPlace: Place?
  @State private var creationPlace: Place?
  
  @State private var showingDetails = false
  @State private var showingCreation = false
  
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
            showingDetails = true
            showingCreation = false
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
          guard showingDetails == false else { return }
          guard let pinLocation = reader.convert(location, from: .local) else { return }
          creationPlace = Place(name: "", coordinate: pinLocation)
          showingCreation = true
          showingDetails = false
        }
        .sheet(isPresented: $showingDetails) {
          if let selectedPlace = selectedPlace {
            PlaceDetailsView(place: selectedPlace)
          }
        }
        .sheet(isPresented: $showingCreation) {
          if let creationPlace = creationPlace {
            PlaceDetailsView(place: creationPlace)
          }
        }
      }
      HeaderView()
    }
  }
}
