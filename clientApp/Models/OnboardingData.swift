//
//  OnboardingData.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation

struct OnboardingData: Identifiable, Hashable {
	let id = UUID()
	let imageName: String
	let title: String
	let description: String
}

let onboardingData = [
	OnboardingData(imageName: "onboarding1", title: "Welcome to Trash Palm", description: "Trash Palm is the #1 source \nto earn rewards just \nby cleaing streets in Cyprus"),
	OnboardingData(imageName: "onboarding2", title: "Clean, Earn Tokens,\nGet Money", description: "Contribute to a more sustainable \ncommunity by cleaning streets!\nEarn tockens and redeem it to real money"),
	OnboardingData(imageName: "onboarding3", title: "Help the environment\nwhile you earn", description: "Join the movement to living more sustainably and feeling good about the clean roadsides"),
]
