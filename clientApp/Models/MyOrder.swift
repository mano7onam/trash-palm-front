//
//  MyOrder.swift
//  clientApp
//
//  Created by  g01dt00th on 26.11.2023.
//

import SwiftUI

struct MyOrder: Identifiable, Hashable {
	enum Status {
		case created
		case reviewRequested
		case done
	}
	
	let id = UUID()
	var status: Status
	let assigneeId: String
	let place: Place
}
