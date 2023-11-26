//
//  Fonts.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import SwiftUI

extension Font {
	static let palmTitle: Font = .custom("Alata", fixedSize: 24)
	static let palmTitle30: Font = .custom("Alata", fixedSize: 30)
	static let palmRegular: Font = .custom("Khula", fixedSize: 16)
	static let palmRegular22: Font = .custom("Khula", fixedSize: 22)
	
	
	static func alata(fixedSize: CGFloat) -> Font {
		.custom("Alata", fixedSize: fixedSize)
	}
	
	static func khula(fixedSize: CGFloat) -> Font {
		.custom("Khula", fixedSize: fixedSize)
	}
}
