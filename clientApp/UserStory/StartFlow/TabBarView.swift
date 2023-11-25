//
//  TabBarView.swift
//  TestGarbage
//
//  Created by Stanislav Zelikson on 24/11/2023.
//

import Foundation
import SwiftUI
import CoreLocation

struct TabBarView: View {
	@State private var mockAnnotations = [
		Place(name: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
		Place(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
		Place(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
		Place(name: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
	]
	
	var body: some View {
		NavigationView {
			TabView {
				MapView(places: mockAnnotations)
					.tabItem {
						Image(systemName: "1.circle")
						Text("Tab 1")
					}
				
				Text("Tab 2")
					.tabItem {
						Image(systemName: "2.circle")
						Text("Tab 2")
					}
				
				Text("Tab 3")
					.tabItem {
						Image(systemName: "3.circle")
						Text("Tab 3")
					}
				
				Text("Tab 4")
					.tabItem {
						Image(systemName: "4.circle")
						Text("Tab 4")
					}
				Text("Tab 5")
					.tabItem {
						Image(systemName: "4.circle")
						Text("Tab 4")
					}
			}
		}
	}
}
