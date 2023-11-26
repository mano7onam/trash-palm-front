//
//  ProfileView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import SwiftUI

struct ProfileView: View {
	
	@EnvironmentObject var vm: AppState
	@EnvironmentObject var router: Router
	@Environment(\.presentationMode) var presentationMode
	
	var body: some View {
		VStack {
			AsyncImage(url: URL(string: vm.profilePicUrl)) { phase in
				if let image = phase.image {
					image
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 170, height: 170)
						.clipShape(Circle()).padding()
				} else {
					ProgressView()
				}
			}.padding(.top, -60)
			ZStack {
				Image("profile_cover")
				VStack {
					Spacer().frame(height: 30)
					Text(vm.givenName)
						.font(.palmTitle30)
						.padding(.top, -20)
					Spacer().frame(height: 40)
					HStack {
						Image("token")
							.padding(.leading, -30)
						Text("123 tokens")
							.font(.palmRegular)
							.padding(.leading, -8)
						Spacer().frame(width: 8)
						Image("NFT")
						Text("5 NFT")
							.font(.palmRegular)
					}
				}
			}
				.padding(.top, -45)
				.padding(.leading, 8)
//			NavigationLink(destination: ChartsView()) {
				Text("Balance")
					.padding()
					.font(.palmRegular)
					.frame(minWidth: 300)
					.background(Color.white)
					.foregroundColor(Color.black)
					.overlay(
						RoundedRectangle(cornerRadius: 100, style: .circular)
							.stroke(Color.olive, lineWidth: 1)
					)
					.onTapGesture {
						router.moveTo(.balance)
						presentationMode.wrappedValue.dismiss()
					}
			//			}
			Button(action: {
				print("challenges")
			}) {
				Text("Challenges")
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
			Button(action: {
				print("list of trash")
			}) {
				Text("List of trash")
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
			Spacer()
		}
	}
}
