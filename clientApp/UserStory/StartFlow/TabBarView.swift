//
//  TabBarView.swift
//  clientApp
//
//  Created by  g01dt00th on 26.11.2023.
//

import SwiftUI

struct TabBarView: View {
	@EnvironmentObject private var router: Router
	
    var body: some View {
		GeometryReader { proxy in
			VStack(spacing: 17) {
				Rectangle()
					.fill(Color(hex: "#D9D9D9"))
					.frame(height: 3)
					.padding(.horizontal, 24)
					.padding(.top, 5)
				
				HStack(spacing: 0) {
					ForEach(Screen.allCases) { screen in
						Group {
							switch screen {
								case .map:
									Image(.map)
								case .balance:
									Image(.balance)
								case .addTrash:
									Image(.plus)
										.padding(EdgeInsets(top: 11, leading: 10, bottom: 11, trailing: 13))
										.background(Color.olive, in: Circle())
								case .listOfGarbage:
									Image(.listOfGarbagge)
								case .challenges:
									Image(.challenges)
								default:
									EmptyView()
							}
						}
						.frame(width: proxy.size.width / 5)
						.onTapGesture {
							router.moveTo(screen)
						}
					}
				}
			}
		}
		.ignoresSafeArea(.keyboard, edges: .bottom)
		.frame(height: 75)
    }
}

#Preview {
    TabBarView()
}
