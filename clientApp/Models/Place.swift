//
//  Place.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import MapKit

struct Place: Identifiable, Hashable {
	let id = UUID()
	let name: String
	let coordinate: CLLocationCoordinate2D
    let tag: Tag
	
	static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.id == rhs.id
	}
}

extension CLLocationCoordinate2D: Hashable {
	public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
		lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
	}
	
	public func hash(into hasher: inout Hasher) {
		hasher.combine(longitude)
		hasher.combine(latitude)
	}
}
