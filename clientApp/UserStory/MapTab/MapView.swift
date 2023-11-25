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
    struct MapSelection: Identifiable {
		var selectedPlace: Place
		var activeSheet: ActiveSheet
        var id: String {
            activeSheet.rawValue
        }
	}
	let places: [Place]

	@State private var activeSheet: ActiveSheet?
	
	@State private var selection: MapSelection?
	
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
                    guard selection == nil else { return }
					guard let pinLocation = reader.convert(location, from: .local) else { return }
					activeSheet = .creation(Place(name: "", coordinate: pinLocation))
				}
				.sheet(item: $activeSheet) { sheet in
					switch sheet {
						case .creation:
							NavigationView {
								CreateGarbageTagView()
							}
						case let .details(place):
							NavigationView {
								GarbageDetails(place: place)
							}
					}
				}
			}
			HeaderView()
		}
	}
}
