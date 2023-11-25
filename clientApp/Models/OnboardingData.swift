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
	OnboardingData(imageName: "1.circle", title: "Hello!", description: "Description 1"),
	OnboardingData(imageName: "2.circle", title: "Title 2", description: "Description 2"),
	OnboardingData(imageName: "3.circle", title: "Title 3", description: "Description 3"),
	OnboardingData(imageName: "4.circle", title: "Title 4", description: "Description 4")
]
