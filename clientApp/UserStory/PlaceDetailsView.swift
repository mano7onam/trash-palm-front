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
          print("Button 1 tapped")
        }) {
          Text("Button 1")
            .bold()
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
          .foregroundColor(Color.green)
        
        Button(action: {
          print("Button 2 tapped")
        }) {
          Text("Button 2")
            .bold()
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
      }
    }
      .padding()
      .background(Color.green.opacity(0.4))
  }
}