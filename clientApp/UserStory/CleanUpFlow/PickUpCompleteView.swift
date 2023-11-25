//
//  PickUpCompleteView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import SwiftUI

struct PickUpCompleteView: View {
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    VStack {
      Image(systemName: "")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding(30)
      Spacer().frame(height: 20)
      Text("You did it!!!")
        .font(.title)
      Spacer().frame(height: 20)
      Text("You earned N tokens")
        .font(.subheadline)
        .foregroundColor(.gray)
        .multilineTextAlignment(.center)
        .padding()
      Spacer()
      Button(action: {
        self.presentationMode.wrappedValue.dismiss()
      }) {
        Text("Finish")
          .bold()
          .padding()
          .background(Color(uiColor: .olive))
          .foregroundColor(.white)
          .cornerRadius(10)
          .frame(minWidth: 300)
        
      }
      Spacer()
    }
  }
}
