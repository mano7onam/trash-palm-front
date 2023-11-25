//
//  ContentView.swift
//  clientApp
//
//  Created by Stanislav Zelikson on 25/11/2023.
//
//

import SwiftUI

struct MainView: View {
  @EnvironmentObject var vm: AppState
  
  var body: some View {
      ZStack {
        if vm.isLoggedIn {
          TabBarView().transition(.opacity)
        } else {
          LoginView().padding()
        }
      }
    }
}
