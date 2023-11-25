//
//  PlaceDetailsView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import SwiftUI
import MapKit

struct PlaceDetailsView: View {
  let place: Place
  
  var body: some View {
    VStack {
      Text(place.name)
              .font(.title)
              .padding()
      
      Map(coordinateRegion: .constant(MKCoordinateRegion(
        center: place.coordinate,
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
      )))
              .disabled(true)
              .frame(height: 200)
              .cornerRadius(10)
              .padding()
      
      Spacer()
    }
  }
}