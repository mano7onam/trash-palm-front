//
//  Router.swift
//  clientApp
//
//  Created by  g01dt00th on 26.11.2023.
//

import SwiftUI

enum Screen: Hashable, CaseIterable, Identifiable {
	case map
	case balance
	case addTrash
	case garbageDetails
	case listOfGarbage
	case challenges
	
	var id: Int { hashValue }
}



final class Router: ObservableObject {
	@Published var currentScreen: Screen = .map
	@Published var transition: AnyTransition = .opacity
	
	func moveTo(_ screen: Screen) {
		guard currentScreen != screen else {
			withAnimation { currentScreen = .map }
			return
		}
		withAnimation {
			currentScreen = screen
		}
	}
}
