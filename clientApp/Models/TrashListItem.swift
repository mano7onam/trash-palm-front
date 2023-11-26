//
//  TrashListItem.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 26/11/2023.
//

import Foundation

struct TrashListItem: Identifiable {
	let id = UUID().uuidString
	let imageName: String
	let detailsImageName: String
	let text: String
	let list: [TrashItem]
}

struct TrashItem: Identifiable {
	let id = UUID().uuidString
	let name: String
	let amount: Int
}