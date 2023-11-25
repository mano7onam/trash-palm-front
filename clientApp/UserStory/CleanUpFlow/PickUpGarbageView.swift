//
//  PickUpGarbageView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import SwiftUI

import PhotosUI

struct PickUpGarbageView: View {
  @State private var comment = ""
  
  @State private var images = [UIImage]()
  
  var body: some View {
    VStack {
      Text("Title")
        .font(.largeTitle)
      ImagePickingView(selectedImages: $images)
      
      Spacer()
      
      TextField("Enter your comment", text: $comment)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      NavigationLink(destination: PickUpCompleteView()) {
        Text("Submit")
          .bold()
          .padding()
          .frame(minWidth: 300)
          .background(Color(uiColor: .olive))
          .foregroundColor(.white)
          .cornerRadius(10)
      }
    }
      .padding()
  }
}
