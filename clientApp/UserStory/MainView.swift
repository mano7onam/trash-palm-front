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
          if vm.onboardingPassed {
            TabBarView().transition(.opacity)
          } else {
            OnboardingView()
          }
        } else {
          LoginView().padding()
        }
      }
    }
}
