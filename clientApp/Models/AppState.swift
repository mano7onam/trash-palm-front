//
//  AppState.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import SwiftUI

class AppState: ObservableObject {
	// Services
	
	lazy var authService = AuthService(state: self)
	
	// UserAuth
	@Published var givenName: String = ""
	@Published var login: String = ""
	@Published var profilePicUrl: String = ""
	@AppStorage("isLoggedIn") var isLoggedIn: Bool = false
	@Published var errorMessage: String = ""
	
	// Settings
	@AppStorage("onboardingPassed") var onboardingPassed: Bool = false
	
	init() {
		authService.check()
	}
}
