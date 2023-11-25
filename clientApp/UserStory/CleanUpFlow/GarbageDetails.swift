//
//  PlaceDetailsView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import SwiftUI
import MapKit

struct GarbageDetails: View {
  let place: Place
  
  @State private var showingActionSheet = false
  
  var body: some View {
    VStack(spacing: 20) {
      Text("Garbage details")
        .font(.title)
      TabView {
        ForEach(0..<5) { index in
          Image("image(index)")
            .resizable()
            .scaledToFill()
            .background(Color.red)
            .frame(width: 230, height: 230 * 16 / 9 )
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
      }
        .tabViewStyle(PageTabViewStyle())
      
      Text("Description")
      Spacer()
      Spacer()
      HStack {
        Button(action: {
          self.showingActionSheet = true
        }) {
          Text("Go there")
            .bold()
            .padding()
            .background(Color(uiColor: .olive))
            .foregroundColor(.white)
            .cornerRadius(10)
        }
          .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Select Navigation App"), buttons: [
              .default(Text("Google Maps")) {

                let googleMaps = "comgooglemaps://?saddr=&daddr=\(place.coordinate.latitude),\(place.coordinate.longitude)&directionsmode=driving"
                
                if let googleUrl = URL(string: googleMaps), UIApplication.shared.canOpenURL(googleUrl) {
                  UIApplication.shared.open(googleUrl)
                }
              },
              .default(Text("Apple Maps")) {
                let appleMaps = "http://maps.apple.com/?daddr=\(place.coordinate.latitude),\(place.coordinate.longitude)&dirflg=d"
                
                if let appleUrl = URL(string: appleMaps), UIApplication.shared.canOpenURL(appleUrl) {
                  UIApplication.shared.open(appleUrl)
                }
              },
              .cancel()
            ])
          }
          .foregroundColor(Color(uiColor: .olive))
        
        NavigationLink(destination: PickUpGarbageView()) {
          Text("Pick up")
            .bold()
            .padding()
            .background(Color(uiColor: .olive))
            .foregroundColor(.white)
            .cornerRadius(10)
        }
      }
    }
      .padding()
      .background(Color(uiColor: .olive).opacity(0.4))
  }
}