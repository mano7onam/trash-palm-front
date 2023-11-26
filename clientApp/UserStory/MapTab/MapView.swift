//
//  MapView.swift
//  TestGarbage
//
//  Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import MapKit
import SwiftUI

struct MapView: View {
	@EnvironmentObject private var appState: AppState
	@EnvironmentObject private var router: Router
		
	@State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
	
	private func makeAnnotation(place: Place) -> Annotation<some View, some View>  {
		Annotation("123", coordinate: place.coordinate) {
			Circle()
				.strokeBorder(.red, lineWidth: 4)
				.frame(width: 20, height: 20)
				.highPriorityGesture(
					TapGesture().onEnded {
						appState.selectedPlace = place
						router.moveTo(.garbageDetails)
					}
				)
		}
	}
	
	
	var body: some View {
		ZStack{
			MapReader { reader in
				Map(position: $position) {
					ForEach(appState.allMarkers) { place in
						makeAnnotation(place: place)
					}
				}
				.onTapGesture { location in
					guard appState.selectedPlace == nil,
						let pinLocation = reader.convert(location, from: .local)
					else { return }
                    appState.selectedPlace = Place(name: "", coordinate: pinLocation, tag: Tag.mock())
					router.moveTo(.addTrash)
				}
			}
			HeaderView()
		}
	}
}
