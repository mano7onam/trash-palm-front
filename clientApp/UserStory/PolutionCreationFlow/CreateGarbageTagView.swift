//
//  CreateGarbageTagView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import struct CoreLocation.CLLocationCoordinate2D
import SwiftUI


struct CreateGarbageTagView: View {
	let place: Place
	
	@State private var comment = ""
	@FocusState private var commentIsFocused: Bool
	@EnvironmentObject private var appState: AppState
	
	var body: some View {
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
					.font(.custom("Alata", fixedSize: 24))
			}
			
			RoundedRectangle(cornerRadius: 20, style: .continuous)
				.fill(Color(hue: 0.283, saturation: 0.04, brightness: 1))
				.overlay(alignment: .bottom) {
					Button {
						print("open action sheet")
					} label: {
						Text("Add Photo")
							.foregroundStyle(Color(hue: 0, saturation: 0, brightness: 0.13))
							.font(.custom("Khula", fixedSize: 16))
							.padding(.bottom, 24)
					}
					.buttonStyle(.plain)
				}
				.overlay {
					Image(.camera)
						.resizable()
						.scaledToFit()
						.padding(EdgeInsets(top: 28, leading: 29, bottom: 66, trailing: 48))
				}
				.frame(height: 310)
				.padding(.horizontal, 45)
				.padding(.vertical, 44)
			
			
			ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
				RoundedRectangle(cornerRadius: 20)
					.inset(by: 0.5)
					.stroke(Color(hue: 0.67, saturation: 0.1, brightness: 0.52), lineWidth: 1)
				
				TextField(text: $comment, prompt: Text("Comment"), axis: .vertical) {
					EmptyView()
				}
				.focused($commentIsFocused)
				.font(.custom("Khula", fixedSize: 16))
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
			
			Text("Donate")
				.font(.custom("Alata", fixedSize: 18))
				.frame(width: 136, height: 44)
				.background(Color(hue: 0.26, saturation: 0.16, brightness: 0.91), in: RoundedRectangle(cornerRadius: 30))
			
			Spacer()
		}
		.padding(.top, 18)
	}
}

#Preview {
	CreateGarbageTagView(place: Place(name: "Preview", coordinate: CLLocationCoordinate2D(latitude: 57, longitude: 35)))
}
