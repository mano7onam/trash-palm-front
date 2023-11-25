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
    struct MapSelection: Identifiable {
		var selectedPlace: Place
		var activeSheet: ActiveSheet
        var id: String {
            activeSheet.rawValue
        }
	}
	let places: [Place]
	
	@State private var selection: MapSelection?
	
	@State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
	
	private func makeAnnotation(place: Place) -> Annotation<some View, some View>  {
		Annotation("123", coordinate: place.coordinate) {
			Circle()
				.strokeBorder(.red, lineWidth: 4)
				.frame(width: 20, height: 20)
				.highPriorityGesture(
					TapGesture().onEnded {
						selection = .init(selectedPlace: place, activeSheet: .details)
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
                    guard selection == nil else { return }
					guard let pinLocation = reader.convert(location, from: .local) else { return }
					let place = Place(name: "", coordinate: pinLocation)
					selection = .init(selectedPlace: place, activeSheet: .creation)
				}
				.sheet(item: $selection) { selectedPlace in
					switch selectedPlace.activeSheet {
					case .creation:
						NavigationView {
							CreateGarbageTagView()
						}
					case .details:
						NavigationView {
							GarbageDetails(place: selectedPlace.selectedPlace)
						}
					}
				}
			}
			HeaderView()
		}
	}
}
