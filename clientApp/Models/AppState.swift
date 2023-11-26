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
        
        Task { @MainActor in
            do {
                let tags = try await backendService.getTags()
                self.allMarkers = getPlacesFromTags(tags: tags)
                
                self.allNftAssets = try await backendService.getNfts()
            }
            catch {
                print(error)
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

private let mockNftAssets = [
	NftAsset(imageName: "nft1", text: "100 cleanings"),
	NftAsset(imageName: "nft2", text: "50 cleanings"),
	NftAsset(imageName: "nft3", text: "Saturday cleaning"),
	NftAsset(imageName: "nft4", text: "Clean beach"),
]

enum ListType {
	case byYou([TrashItem])
	case voted([TrashItem])
	case cleanedByYou([TrashItem])
}


let items: [TrashItem] =
	[
		.init(name: "Clean Beach", amount: 5),
		.init(name: "Clean saturday", amount: 3),
		.init(name: "Clean near cafe", amount: 7),
		.init(name: "Clean event 1", amount: 2),
		.init(name: "Clean event 2", amount: 4)
		
    ]


private let mockTrashList = [
    TrashListItem(imageName: "by_you", detailsImageName: "cameraboy", text: "Created by you", list: Array(items.prefix(2))),
    TrashListItem(imageName: "voted", detailsImageName: "vote", text: "Voted by you", list: [
      items[2]
    ]),
    TrashListItem(imageName: "bin", detailsImageName: "binboy", text: "Cleaned by you", list: items.suffix(2)),
    TrashListItem(imageName: "all_types", detailsImageName: "all_types", text: "All types", list: items),
]
