//
//  ImagePickingView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import SwiftUI

import PhotosUI

struct ImagePickingView: View {
	
	@Binding var selectedImages: [UIImage]
	
	
	@State private var images = [UIImage]() {
		didSet {
			selectedImages = images
		}
	}
	@State private var showingImagePicker = false
	@State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
	@State private var showingActionSheet = false
	
	
	var body: some View {
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
				.background(Color(uiColor: .olive))
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
			if sourceType == .camera {
				ImagePicker(images: $images, sourceType: $sourceType)
			} else {
				PhotoPicker(images: $images)
			}
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

struct PhotoPicker: UIViewControllerRepresentable {
	@Binding var images: [UIImage]
	
	func makeUIViewController(context: Context) -> PHPickerViewController {
		var config = PHPickerConfiguration()
		config.selectionLimit = 0
		config.filter = .images
		let picker = PHPickerViewController(configuration: config)
		picker.delegate = context.coordinator
		return picker
	}
	
	func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: PHPickerViewControllerDelegate {
		private let parent: PhotoPicker
		
		init(_ parent: PhotoPicker) {
			self.parent = parent
		}
		
		func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
			for result in results {
				if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
					result.itemProvider.loadObject(ofClass: UIImage.self) { (newImage, error) in
						if let error = error {
							print(error.localizedDescription)
						} else {
							DispatchQueue.main.async {
								if let image = newImage as? UIImage {
									self.parent.images.append(image)
								}
							}
						}
					}
				}
			}
			picker.dismiss(animated: true)
		}
	}
}
