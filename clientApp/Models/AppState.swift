//
//  AppState.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import SwiftUI
import struct CoreLocation.CLLocationCoordinate2D

class AppState: ObservableObject {
	// Services
	
	lazy var authService = AuthService(state: self)
	let locationService = LocationService()
	
	// UserAuth
	@Published var givenName: String = ""
	@Published var login: String = ""
	@Published var profilePicUrl: String = ""
	@AppStorage("isLoggedIn") var isLoggedIn: Bool = false
	@Published var errorMessage: String = ""
	
	// Settings
	@AppStorage("onboardingPassed") var onboardingPassed: Bool = false
	
	// Markers
	@Published private(set) var allMarkers: [Place] = []
	@Published var selectedPlace: Place?
	
	init() {
		authService.check()
		allMarkers = mockAnnotations
	}
}

private let mockAnnotations = [
	Place(name: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
	   Place(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
	   Place(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
	   Place(name: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
   ]
