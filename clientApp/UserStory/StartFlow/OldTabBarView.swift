//
//  TabBarView.swift
//  TestGarbage
//
//  Created by Stanislav Zelikson on 24/11/2023.
//

import Foundation
import SwiftUI
import CoreLocation

struct OldTabBarView: View {
	var body: some View {
		NavigationView {
			TabView {
				MapView()
					.tabItem {
						Image(systemName: "1.circle")
						Text("Tab 1")
					}
				
				Text("Tab 2")
					.tabItem {
						Image(systemName: "2.circle")
						Text("Tab 2")
					}
				
				Text("Tab 3")
					.tabItem {
						Image(systemName: "3.circle")
						Text("Tab 3")
					}
				
				Text("Tab 4")
					.tabItem {
						Image(systemName: "4.circle")
						Text("Tab 4")
					}
				Text("Tab 5")
					.tabItem {
						Image(systemName: "4.circle")
						Text("Tab 4")
					}
			}
		}
	}
}
