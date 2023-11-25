//
//  PickUpCompleteView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import SwiftUI

struct PickUpCompleteView: View {
	@Environment(\.dismiss) var dismiss
	
	var body: some View {
		VStack {
			Image(systemName: "")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.padding(30)
			Spacer().frame(height: 20)
			Text("You did it!!!")
				.font(.title)
			Spacer().frame(height: 20)
			Text("You earned N tokens")
				.font(.subheadline)
				.foregroundColor(.gray)
				.multilineTextAlignment(.center)
				.padding()
			Spacer()
			Button(action: dismiss.callAsFunction) {
				Text("Finish")
					.bold()
					.padding()
					.background(Color.olive)
					.foregroundColor(.white)
					.cornerRadius(10)
					.frame(minWidth: 300)
				
			}
			Spacer()
		}
	}
}
