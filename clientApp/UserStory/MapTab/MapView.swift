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
	enum ActiveSheet: String, Identifiable {
		case details
		case creation
		var id: String {
			rawValue
		}
	}
	let places: [Place]
	@State private var selectedPlace: Place?
	@State private var activeSheet: ActiveSheet?
	
	
	@State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
	
	private func makeAnnotation(place: Place) -> Annotation<some View, some View>  {
		Annotation("123", coordinate: place.coordinate) {
			Circle()
				.strokeBorder(.red, lineWidth: 4)
				.frame(width: 20, height: 20)
				.highPriorityGesture(
					TapGesture().onEnded {
						selectedPlace = place
						Task {
							try await Task.sleep(nanoseconds: (1 * NSEC_PER_SEC))
							activeSheet = .details
						}
					}
				)
		}
	}
	
	var body: some View {
		ZStack{
			MapReader { reader in
				Map(position: $position) {
					ForEach(places) { place in
						makeAnnotation(place: place)
					}
				}
				.onTapGesture { location in
					guard let pinLocation = reader.convert(location, from: .local) else { return }
					selectedPlace = Place(name: "", coordinate: pinLocation)
					activeSheet = .creation
				}
				.sheet(item: $selectedPlace) { selectedPlace in
					switch activeSheet {
						case .creation:
							NavigationView {
								CreateGarbageTagView()
							}
						case .details:
							NavigationView {
								GarbageDetails(place: selectedPlace)
							}
						case .none:
							EmptyView()
					}
				}
			}
			HeaderView()
		}
	}
}
