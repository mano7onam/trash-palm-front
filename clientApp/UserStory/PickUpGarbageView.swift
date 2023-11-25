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
  @State private var images = [UIImage]()
  @State private var comment = ""
  @State private var showingImagePicker = false
  @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
  @State private var showingActionSheet = false
  
  var body: some View {
    VStack {
      Text("Title")
        .font(.largeTitle)
      
      ScrollView(.horizontal, showsIndicators: true) {
        HStack {
          Button(action: {
            self.showingActionSheet = true
          }) {
            Image(systemName: "plus")
              .resizable()
              .scaledToFit()
              .frame(width: 70, height: 70)
              .foregroundColor(.gray)
              .clipShape(Rectangle())
          }
            .frame(width: 230, height: 400)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 20))
          
          ForEach(images.indices, id: \.self) { index in
            Button(action: {
              images.remove(at: index)
            }) {
              Image(uiImage: images[index])
                .resizable()
                .scaledToFit()
            }
          }
        }
      }
      
      Spacer()
      
      TextField("Enter your comment", text: $comment)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      Button(action: {
        print("submit result")
      }) {
        Text("Submit")
          .bold()
          .padding()
          .frame(minWidth: 300)
          .background(Color.green)
          .foregroundColor(.white)
          .cornerRadius(10)
      }
    }
      .padding()
      .actionSheet(isPresented: $showingActionSheet) {
        ActionSheet(title: Text("Choose source"), buttons: [
          .default(Text("Camera"), action: {
            self.sourceType = .camera
            self.showingImagePicker = true
          }),
          .default(Text("Photo Library"), action: {
            self.sourceType = .photoLibrary
            self.showingImagePicker = true
          }),
          .cancel()
        ])
      }
      .sheet(isPresented: $showingImagePicker) {
        ImagePicker(images: $images, sourceType: $sourceType)
      }
  }
}


struct ImagePicker: UIViewControllerRepresentable {
  @Binding var images: [UIImage]
  @Binding var sourceType: UIImagePickerController.SourceType
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.sourceType = sourceType
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private let parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let image = info[.originalImage] as? UIImage {
        parent.images.append(image)
      }
      
      picker.dismiss(animated: true)
    }
  }
}
