//
//  CreateGarbageTagView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import struct CoreLocation.CLLocationCoordinate2D
import SwiftUI
import PhotosUI

extension UIImage: Transferable {
	public static var transferRepresentation: some TransferRepresentation {
		DataRepresentation(importedContentType: .image) { data in
			guard let uiImage = UIImage(data: data) else {
				throw NSError(domain: "import failed", code: -1)
			}
			return uiImage
		}
	}
}

struct CreateGarbageTagView: View {
	@State private var comment = ""
	@FocusState private var commentIsFocused: Bool
	@EnvironmentObject private var appState: AppState
	@State private var showActionsSheet = false
	@State private var openPhotoPicker = false
	@State private var openCameraPicker = false
	
	@State private var selectedTransferable = [PhotosPickerItem]()
	@State private var selectedImages = [UIImage]()
	
	var body: some View {
		ZStack(alignment: .bottom) {
			main
				.blur(radius: showActionsSheet ? 4 : 0)
				.allowsHitTesting(!showActionsSheet)
			
			if showActionsSheet {
				Color.white.opacity(0.01)
					.onTapGesture {
						withAnimation {
							showActionsSheet = false
						}
					}
				
				sheet
			}
			
			if openCameraPicker {
				ImagePicker(images: $selectedImages, sourceType: .camera)
			}
			
		}
		.padding(.top, 18)
		.photosPicker(
			isPresented: $openPhotoPicker,
			selection: $selectedTransferable,
			maxSelectionCount: nil,
			selectionBehavior: .default,
			matching: .all(of: [.images]),
			preferredItemEncoding: .compatible
		)
		.onChange(of: selectedTransferable) { _, newValue in
			Task {
				let newImages = try await withThrowingTaskGroup(of: [UIImage].self) { group in
					for transferable in newValue {
						group.addTask {
							guard let image = try await transferable.loadTransferable(type: UIImage.self) else { return [] }
							return [image]
						}
					}
					
					let allImages = try await group.reduce([UIImage](), +)
					return allImages
				}
				await MainActor.run {
					selectedImages = newImages
					withAnimation {
						showActionsSheet = false
					}
				}
			}
		}
		.onChange(of: selectedImages) { _, newValue in
			newValue.forEach {
				print($0.size, $0.scale)
			}
		}
	}
	
	var main: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(spacing: 0) {
				HStack {
					Spacer()
					
					AsyncImage(url: URL(string: appState.profilePicUrl)) { phase in
						switch phase {
							case .empty, .failure:
								Image(.accountPlaceholder)
							case let .success(image):
								image
									.resizable()
									.scaledToFit()
									.frame(width: 40)
									.clipShape(Circle())
							@unknown default:
								Image(.accountPlaceholder)
						}
					}
					.padding(.trailing)
					
				}
				.overlay(alignment: .bottom) {
					Text("Add new trash")
						.font(.alata(fixedSize: 24))
				}
				Spacer().frame(height: 16)
				
				ImagePickingView(selectedImages: $selectedImages)
					.padding()
					.frame(maxHeight: 400)
					.onTapGesture {
						commentIsFocused = false
					}
				Spacer().frame(height: 16)
				
				ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
					RoundedRectangle(cornerRadius: 20)
						.inset(by: 0.5)
						.stroke(Color(hue: 0.67, saturation: 0.1, brightness: 0.52), lineWidth: 1)
					
					TextField(text: $comment, prompt: Text("Comment"), axis: .vertical) {
						EmptyView()
					}
					.focused($commentIsFocused)
					.font(.khula(fixedSize: 16))
					.padding(10)
					.toolbar {
						ToolbarItem(placement: .keyboard) {
							HStack {
								Spacer()
								Button("Done") { commentIsFocused = false }
							}
						}
					}
				}
				.frame(height: 124)
				.padding(.horizontal, 23)
				.padding(.bottom, 29)
				
                HStack {
                    Button {
                        print("open donate")
                    } label: {
                        Text("Donate")
                            .font(.alata(fixedSize: 18))
                            .frame(width: 136, height: 44)
                            .background(Color(hue: 0.26, saturation: 0.16, brightness: 0.91), in: RoundedRectangle(cornerRadius: 30))
                    }
                    .buttonStyle(.plain)
                    Button(action: {
                        guard let lon = appState.selectedPlace?.coordinate.longitude,
                              let lat = appState.selectedPlace?.coordinate.latitude else { return }
                        let title = "New thrash"
                        Task {
                            let description = comment
                            try await appState.backendService.createTagWithImages(lon: lon, lat: lat, title: title, description: description, prize: 0, images: selectedImages)
                        }
                    }) {
                        Text("Add")
                            .font(.alata(fixedSize: 18))
                            .frame(width: 136, height: 44)
                            .background(Color(hue: 0.26, saturation: 0.16, brightness: 0.91), in: RoundedRectangle(cornerRadius: 30))
                    }
                    .buttonStyle(.plain)
                }
				
				Spacer()
			}
		}
		
	}
	
	var sheet: some View {
		VStack(spacing: 0) {
			Text("Add photo")
				.font(.alata(fixedSize: 24))
				.padding(.top, 33)
				.padding(.bottom, 57)
			
			Button {
				openCameraPicker = true
			} label: {
				RoundedRectangle(cornerRadius: 13)
					.stroke(Color(hex: "787885"), lineWidth: 1)
					.frame(height: 53)
					.overlay(alignment: .leading) {
						Text("Use camera")
							.font(.khula(fixedSize: 16))
							.foregroundStyle(Color.black)
							.padding(.leading, 20)
					}
			}
			.buttonStyle(.plain)
			.padding(.bottom, 55)
			
			Button {
				openPhotoPicker = true
			} label: {
				RoundedRectangle(cornerRadius: 13)
					.stroke(Color(hex: "787885"), lineWidth: 1)
					.frame(height: 53)
					.overlay(alignment: .leading) {
						Text("Choose from library")
							.font(.khula(fixedSize: 16))
							.foregroundStyle(Color.black)
							.padding(.leading, 20)
					}
			}
			.buttonStyle(.plain)
			.padding(.bottom, 55)
		}
		.background(Color.white)
		.padding(.horizontal, 10)
		.transition(.move(edge: .bottom))
	}
}

#Preview {
	CreateGarbageTagView()
		.environmentObject(AppState())
}
