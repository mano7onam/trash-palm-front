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
	enum ActiveSheet: Identifiable, Hashable {
		case details(Place)
		case creation(Place)
		
		var id: Int {
			hashValue
		}
	}

	let places: [Place]

	@State private var activeSheet: ActiveSheet?
		
	@State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
	
	private func makeAnnotation(place: Place) -> Annotation<some View, some View>  {
		Annotation("123", coordinate: place.coordinate) {
			Circle()
				.strokeBorder(.red, lineWidth: 4)
				.frame(width: 20, height: 20)
				.highPriorityGesture(
					TapGesture().onEnded {
						activeSheet = .details(place)
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
					guard activeSheet == nil,
						let pinLocation = reader.convert(location, from: .local)
					else { return }
					activeSheet = .creation(Place(name: "", coordinate: pinLocation))
				}
				.sheet(item: $activeSheet) { sheet in
					switch sheet {
						case let .creation(place):
								CreateGarbageTagView(place: place)
						case let .details(place):
								GarbageDetails(place: place)
					}
				}
			}
			HeaderView()
		}
	}
}
