//
//  PlaceDetailsView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import SwiftUI
import MapKit

struct GarbageDetails: View {
	@EnvironmentObject private var appState: AppState
	
	@State private var showingActionSheet = false
	
	var body: some View {
		VStack(spacing: 20) {
			Text("Garbage details")
				.font(.title)
			TabView {
                ForEach(appState.selectedPlace?.tag.photoUrls ?? [], id: \.self) { photoUrl in
                    AsyncImage(url: URL(string: photoUrl))
                        .frame(width: 230, height: 230 * 16 / 9)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                }
			}
			.tabViewStyle(PageTabViewStyle())
			
			Text("Description")
			Spacer()
			Spacer()
			HStack {
				Button(action: {
					self.showingActionSheet = true
				}) {
					Text("Go there")
						.bold()
						.padding()
						.background(Color.olive)
						.foregroundColor(.white)
						.cornerRadius(10)
				}
				.actionSheet(isPresented: $showingActionSheet) {
					ActionSheet(title: Text("Select Navigation App"), buttons: [
						.default(Text("Google Maps")) {
							guard let location = appState.selectedPlace?.coordinate else { return }
							let googleMaps = "comgooglemaps://?saddr=&daddr=\(location.latitude),\(location.longitude)&directionsmode=driving"
							
							if let googleUrl = URL(string: googleMaps), UIApplication.shared.canOpenURL(googleUrl) {
								UIApplication.shared.open(googleUrl)
							}
						},
						.default(Text("Apple Maps")) {
							guard let location = appState.selectedPlace?.coordinate else { return }

							let appleMaps = "http://maps.apple.com/?daddr=\(location.latitude),\(location.longitude)&dirflg=d"
							
							if let appleUrl = URL(string: appleMaps), UIApplication.shared.canOpenURL(appleUrl) {
								UIApplication.shared.open(appleUrl)
							}
						},
						.cancel()
					])
				}
				.foregroundColor(Color.olive)
				
				NavigationLink(destination: PickUpGarbageView()) {
					Text("Pick up")
						.bold()
						.padding()
						.background(Color.olive)
						.foregroundColor(.white)
						.cornerRadius(10)
				}
			}
		}
		.padding()
		.background(Color.olive.opacity(0.4))
		.onDisappear { appState.selectedPlace = nil }
	}
}
