//
//  LoginScreen.swift
//  TestGarbage
//
//  Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import SwiftUI
import GoogleSignIn

struct LoginView: View {
	@EnvironmentObject var vm: AppState
	enum LoginType: Int {
		case login
		case signIn
	}
	
	@State private var loginType: LoginType = .login
	@State private var username = ""
	@State private var password = ""
	
	@State private var showingAlert = false
	
	var loginView: some View {
		VStack {
			Text("Username")
				.frame(maxWidth: .infinity, alignment: .leading)
			TextField("Username", text: $username)
				.padding()
				.background(Capsule().strokeBorder(Color.gray, lineWidth: 0.5))
			Text("Password")
				.frame(maxWidth: .infinity, alignment: .leading)
			SecureField("Password", text: $password)
				.padding()
				.background(Capsule().strokeBorder(Color.gray, lineWidth: 0.5))
			Button(action: {
				showingAlert = true
			}) {
				Text("Login")
					.bold()
					.foregroundColor(.white)
					.padding()
					.frame(width: 200)
					.background(Color.olive, in: RoundedCorners(tl: 0, tr: 30, bl: 30, br: 30))
			}
			.padding()
			.alert(isPresented: $showingAlert) {
				Alert(title: Text("Coming Soon"), message: Text("Use Google auth"), dismissButton: .default(Text("Got it!")))
			}
		}
	}
	
	var signUpView: some View {
		VStack(spacing: 20) {
			Button(action: {
				vm.authService.signIn()
			}) {
				Text("Sign Up with Google")
					.padding()
					.font(.palmRegular)
					.frame(minWidth: 300)
					.background(Color.white)
					.foregroundColor(Color.black)
					.overlay(
						RoundedRectangle(cornerRadius: 100, style: .circular)
							.stroke(Color.olive, lineWidth: 1)
					)
			}
			Text("OR")
				.bold()
			Button(action: {
				showingAlert = true
			}) {
				Text("Sign Up with Email")
					.padding()
					.font(.palmRegular)
					.frame(minWidth: 300)
					.background(Color.white)
					.foregroundColor(Color.black)
					.overlay(
						RoundedRectangle(cornerRadius: 100, style: .circular)
							.stroke(Color.olive, lineWidth: 1)
					)
			}
			.alert(isPresented: $showingAlert) {
				Alert(title: Text("Coming Soon"), message: Text("Use Google auth"), dismissButton: .default(Text("Got it!")))
			}
			Text("By tapping Sign Up, you acnowledge \nthat you have agreed the Terms and Conditions\nand read the Privacy Policy")
				.foregroundColor(.gray)
				.multilineTextAlignment(.center)
				.font(.system(size: 13))
		}
		.padding()
	}
	
	var body: some View {
		VStack {
			Image(.loginLogo)
				.resizable()
				.scaledToFit()
				.frame(height: 350)
				.offset(x: -25)
			
			Spacer()
			Picker("Options", selection: $loginType.animation()) {
				Text("Login").tag(LoginType.login)
				Text("SignUp").tag(LoginType.signIn)
			}
			.pickerStyle(SegmentedPickerStyle())
			.padding()
			Spacer()
			if loginType == .login {
				loginView
					.transition(.move(edge: .leading))
			} else {
				signUpView
					.transition(.move(edge: .trailing))
			}
		}
		.padding()
	}
}


#Preview {
	LoginView().environmentObject(AppState())
}
