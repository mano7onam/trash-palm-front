//
//  RouterView.swift
//  clientApp
//
//  Created by  g01dt00th on 26.11.2023.
//

import SwiftUI
import CoreLocation

struct RouterView: View {
	@StateObject private var router = Router()
	@EnvironmentObject private var appState: AppState
	
    var body: some View {
		ZStack(alignment: .bottom) {
			switch appState.isLoggedIn {
				case false:
					LoginView()
				case true:
					switch appState.onboardingPassed {
						case false:
							OnboardingView()
						case true:
							Group {
								NavigationView {
									MapView()
										.opacity(router.currentScreen == .map ? 1 : 0)
								}
								
								switch router.currentScreen {
									case .map:
										EmptyView()
									case .balance:
										NavigationView {
											ChartsView()
										}
									case .addTrash:
										CreateGarbageTagView()
									case .garbageDetails:
										NavigationView {
											GarbageDetails()
										}
									case .listOfGarbage:
										NavigationView {
											TrashListView()
										}
									case .challenges:
										Rectangle()
											.fill(Color.white)
											.overlay {
												Text("Challenges!")
											}
									case .checkCleaning:
										CheckCleaningView()
								}
							}
							.background(Color.white)
							.padding(.bottom, 75)
							.transition(router.transition)
							
							TabBarView()
					}
			}
		}
		.environmentObject(router)
    }
}

#Preview {
    RouterView()
		.environmentObject(AppState())
}
