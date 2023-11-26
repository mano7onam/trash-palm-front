//
//  DonationView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 26/11/2023.
//

import Foundation
import SwiftUI

struct DonationView: View {
	@State private var donationAmount: Int? = 5
	@State private var paymentMethod = "Credit Card"
	@State private var customDonationAmount = ""
	
	let donationOptions = [5, 10]
	let paymentMethods = ["Credit Card", "Apple Pay"]
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Spacer()
                Image("heart_small")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipped()
			}
			
			Text("Screen Title")
				.font(.largeTitle)
				.padding(.bottom)
			
			HStack {
				ForEach(donationOptions, id: \.self) { amount in
					Button(action: {
						self.donationAmount = amount
						self.customDonationAmount = ""
					}) {
						Text("\(amount)")
							.padding()
							.background(donationAmount == amount ? Color.blue : Color.gray)
							.foregroundColor(.white)
							.cornerRadius(10)
					}
				}
				
				TextField("Custom amount", text: $customDonationAmount, onEditingChanged: { _ in
					self.donationAmount = nil
				})
					.keyboardType(.numberPad)
					.textFieldStyle(RoundedBorderTextFieldStyle())
			}
			
			Picker("Payment Method", selection: $paymentMethod) {
				ForEach(paymentMethods, id: \.self) { method in
					Text(method).tag(method)
				}
			}
				.pickerStyle(SegmentedPickerStyle())
			
			Button(action: {}) {
				Text("Submit")
					.padding()
					.background(Color.blue)
					.foregroundColor(.white)
					.cornerRadius(10)
			}
				.padding(.top)
		}
			.padding()
	}
}

#Preview {
		DonationView()
}
