//
//  HeaderView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import SwiftUI

struct HeaderView: View {
  
  @EnvironmentObject var vm: AppState
  
  var body: some View {
    VStack {
      ZStack {
        Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(1), Color.white.opacity(0.9), Color.white.opacity(0.7), Color.white.opacity(0)]),
                     startPoint: .top,
                     endPoint: .bottom)).frame(height: 100)
        HStack {
          Spacer()
          NavigationLink(destination: ProfileView()) {
            AsyncImage(url: URL(string: vm.profilePicUrl)) { phase in
              if let image = phase.image {
                image.resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 50).clipShape(Circle()).padding()
              } else {
                ProgressView()
              }
            }
            .padding(.top, 30)
          }
          
        }
      }
      Spacer()
    }.ignoresSafeArea()
  }
}