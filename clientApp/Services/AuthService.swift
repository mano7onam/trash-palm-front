//
//  UserAuthModel.swift
//  TestGarbage
//
//  Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import GoogleSignIn

final class AuthService {
	
	private weak var appState: AppState?
	
	init(state: AppState) {
		self.appState = state
	}
	
	func checkStatus(){
		if (GIDSignIn.sharedInstance.currentUser != nil) {
			let user = GIDSignIn.sharedInstance.currentUser
			guard let user = user else { return }
			let givenName = user.profile?.givenName
			let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
			appState?.givenName = givenName ?? ""
			appState?.login = user.profile?.email ?? ""
			appState?.profilePicUrl = profilePicUrl
			appState?.isLoggedIn = true
		} else {
			appState?.isLoggedIn = false
			appState?.givenName = "Not Logged In"
			appState?.profilePicUrl =  ""
		}
	}
	
	func check(){
		GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
			if let error = error {
				self.appState?.errorMessage = "error: \(error.localizedDescription)"
			}
			
			self.checkStatus()
		}
	}
	
	func signIn(){
		
		guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
		
		let signInConfig = GIDConfiguration(clientID: "182628399243-pum6fp8cptidu4fn92pdpp57p5lf6gs2.apps.googleusercontent.com")
		GIDSignIn.sharedInstance.configuration = signInConfig
		GIDSignIn.sharedInstance.signIn(
			withPresenting: presentingViewController) { user, error in
				if let error = error {
					self.appState?.errorMessage = "error: \(error.localizedDescription)"
				}
				self.checkStatus()
			}
	}
	
	func signOut(){
		GIDSignIn.sharedInstance.signOut()
		self.checkStatus()
	}
}
