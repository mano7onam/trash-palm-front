//
//  NftAsset.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 26/11/2023.
//

import Foundation

struct NftAsset: Identifiable {
	var id: String {
		uuid.uuidString
	}
	
	let uuid = UUID()
	let imageName: String
	let text: String
}