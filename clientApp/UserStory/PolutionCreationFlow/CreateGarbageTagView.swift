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
	@State private var showActionsSheet = false
	
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
			
		}
		.padding(.top, 18)
	}
	
	var main: some View {
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
			
			Button {
				commentIsFocused = false
				withAnimation {
					showActionsSheet = true
				}
			} label: {
				RoundedRectangle(cornerRadius: 20, style: .continuous)
					.fill(Color(hue: 0.283, saturation: 0.04, brightness: 1))
					.overlay(alignment: .bottom) {
						Text("Add Photo")
							.foregroundStyle(Color(hue: 0, saturation: 0, brightness: 0.13))
							.font(.khula(fixedSize: 16))
							.padding(.bottom, 24)
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
			}
			.buttonStyle(.plain)
			
			
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
			
			Button {
				print("open donate")
			} label: {
				Text("Donate")
					.font(.alata(fixedSize: 18))
					.frame(width: 136, height: 44)
					.background(Color(hue: 0.26, saturation: 0.16, brightness: 0.91), in: RoundedRectangle(cornerRadius: 30))
			}
			.buttonStyle(.plain)
			
			Spacer()
		}
		
	}
	
	var sheet: some View {
		VStack(spacing: 0) {
			Text("Add photo")
				.font(.alata(fixedSize: 24))
				.padding(.top, 33)
				.padding(.bottom, 57)
			
			Button {
				print("open camera")
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
				print("open galery")
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
	CreateGarbageTagView(place: Place(name: "Preview", coordinate: CLLocationCoordinate2D(latitude: 57, longitude: 35)))
}
