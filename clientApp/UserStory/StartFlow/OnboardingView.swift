//
//  OnboardingView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation

import SwiftUI

struct OnboardingView: View {
	@EnvironmentObject var vm: AppState
	
	@State var selectedTab = 0
	var body: some View {
		TabView(selection: $selectedTab) {
			ForEach(onboardingData.indices) { index in
				OnboardingPageView(data: onboardingData[index], isLastPage: index == onboardingData.count - 1) {
					withAnimation {
						if index == onboardingData.count - 1 {
							vm.onboardingPassed = true
						} else {
							selectedTab += 1
						}
					}
				}
			}
		}
		.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
		.background(Color.gray)
	}
}

struct OnboardingPageView: View {
	let data: OnboardingData
	let isLastPage: Bool
	let action: () -> Void
	
	var body: some View {
		VStack {
			Image(data.imageName)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.padding(30)
			Spacer().frame(height: 20)
			Text(data.title)
				.font(.title)
			Spacer().frame(height: 20)
			Text(data.description)
				.font(.subheadline)
				.foregroundColor(.palmSecondary)
				.multilineTextAlignment(.center)
				.padding()
			Spacer()
			Button(action: action) {
				Text(isLastPage ? "Finish" : "Next")
					.bold()
					.padding()
                    .frame(minWidth: 200)
					.background(Color.olive)
					.foregroundColor(.white)
                    .clipShape(RoundedCorners(tl: 0, tr: 30, bl: 30, br: 30))
				
			}
			Spacer()
		}
	}
}

#Preview {
    OnboardingView()
		.environmentObject(AppState())
}
