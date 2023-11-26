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
	let text: String
	
}