//
//  LoginScreen.swift
//  TestGarbage
//
//  Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import SwiftUI
import GoogleSignIn

struct LoginView: View {
  @EnvironmentObject var vm: AppState
  var body: some View {
    VStack {
      Text(vm.givenName)
      AsyncImage(url: URL(string: vm.profilePicUrl)).frame(width: 100, height: 100)
      Button(action: {
        vm.authService.signIn()
      }) {
        Text("Sign In")
      }
    }
  }
}
