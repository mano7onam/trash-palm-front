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
    lazy var backendService = BackendService(email: "some@gmail.com")
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
	
	// NFT
	@Published private(set) var allNftAssets: [NftAsset] = []
	
	// TrashList
	@Published private(set) var allTrashLists: [TrashListItem] = []
	
	init() {
		authService.check()
		allNftAssets = mockNftAssets
		allTrashLists = mockTrashList
        backendService.setEmail(email: self.login)
        
        Task {
            do {
                let tags = try await backendService.getTags()
                self.allMarkers = getPlacesFromTags(tags: tags)
            }
            catch {
                print(error.localizedDescription.debugDescription)
            }
        }
        
	}
    
    func getPlacesFromTags(tags: [Tag]) -> [Place] {
        return tags.map { tag in
            let coordinate = CLLocationCoordinate2D(latitude: tag.lat, longitude: tag.lon)
            return Place(name: tag.title, coordinate: coordinate, tag: tag)
        }
    }
}

//private let mockAnnotations = [
//	Place(name: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
//	   Place(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
//	   Place(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
//	   Place(name: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
//   ]


private let mockNftAssets = [
	NftAsset(imageName: "nft1", text: "100 cleanings"),
	NftAsset(imageName: "nft2", text: "50 cleanings"),
	NftAsset(imageName: "nft3", text: "Saturday cleaning"),
	NftAsset(imageName: "nft4", text: "Clean beach"),
]


private let mockTrashList = [
	TrashListItem(imageName: "cameraboy", text: "Created by you"),
	TrashListItem(imageName: "voted", text: "Voted by you"),
	TrashListItem(imageName: "binboy", text: "Cleaned by you"),
	TrashListItem(imageName: "all_types", text: "All types"),
]
