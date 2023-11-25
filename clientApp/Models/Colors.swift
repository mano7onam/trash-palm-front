//
//  Colors.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import SwiftUI

extension Color {
	static let olive = Color(hex: "81A33F")
}

extension Color {
	init(hex: String) {
		self.init(UIColor(hex: hex))
	}
}

extension UIColor {
	convenience init(hex: String) {
		let scanner = Scanner(string: hex)
		scanner.currentIndex = hex.hasPrefix("#") ? scanner.string.index(after: scanner.currentIndex) : scanner.currentIndex
		
		var rgbValue: UInt64 = 0
		scanner.scanHexInt64(&rgbValue)
		
		let r = (rgbValue & 0xff0000) >> 16
		let g = (rgbValue & 0xff00) >> 8
		let b = rgbValue & 0xff
		
		self.init(
			red: CGFloat(r) / 0xff,
			green: CGFloat(g) / 0xff,
			blue: CGFloat(b) / 0xff,
			alpha: 1
		)
	}
}
