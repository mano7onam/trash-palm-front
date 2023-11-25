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
				Image("profile.cover")
				VStack {
					Spacer().frame(height: 30)
					Text(vm.givenName)
						.font(.palmTitle30)
						.padding(.top, -20)
					Spacer().frame(height: 40)
					HStack {
						Image("token.icon")
						Text("123 tokens")
						Image("nft.icon")
						Text("5 NFT")
					}
				}
			}.padding(.top, -45)
			Button(action: {
				print("balance")
			}) {
				Text("Balance")
					.padding()
					.frame(minWidth: 300)
					.background(Color.white)
					.foregroundColor(Color.black)
					.overlay(
						RoundedRectangle(cornerRadius: 100, style: .circular)
							.stroke(Color.olive, lineWidth: 1)
					)
			}
			Button(action: {
				print("challenges")
			}) {
				Text("Challenges")
					.padding()
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
