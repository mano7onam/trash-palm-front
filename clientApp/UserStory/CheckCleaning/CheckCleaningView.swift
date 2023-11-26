//
//  CheckCleaningView.swift
//  clientApp
//
//  Created by  g01dt00th on 26.11.2023.
//

import SwiftUI

struct CheckCleaningView: View {
	@EnvironmentObject private var router: Router
	@EnvironmentObject private var appState: AppState
	
	@State private var selectedOrderIndex: Int = 0
	
	var body: some View {
		VStack(spacing: 0) {
			Text("Check cleaning")
				.font(.alata(fixedSize: 24))
				.padding(.top, 24)
			
			Image(.trashPalm)
				.padding(.top, -20)
				.overlay(alignment: .bottomLeading) {
					Text("Trash NI")
						.font(.alata(fixedSize: 24))
						.padding(.bottom, 40)
				}
				.padding(.bottom, 40)
			
			TabView(selection: $selectedOrderIndex.animation()) {
				ForEach(Array(appState.myOrders.enumerated()), id: \.offset) { index, order in
					VStack(alignment: .leading, spacing: 0) {
						Text(order.assigneeId)
							.font(.alata(fixedSize: 20))
							.padding(.top, 30)
							.padding(.leading, 30)
						
						Text("cleaned your trash")
							.font(.khula(fixedSize: 16))
							.foregroundStyle(Color(hex: "#7A7585"))
							.padding(.leading, 30)
						
						ZStack {
							Capsule()
								.foregroundStyle(Color(hex: "#D9D9D9").opacity(0.9))
							
							let progress: CGFloat = switch order.status {
							case .created: 150
							case .reviewRequested: 80
							case .done: 0
							}
							Capsule()
								.foregroundStyle(Color.olive)
								.padding(.leading, progress)
						}
						.frame(height: 20)
						.padding(.leading, 130)
						.padding(.trailing, 20)
						.padding(.vertical, 30)
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					.background(Color.sunny, in: RoundedRectangle(cornerRadius: 40))
					.padding(.horizontal)
					.tag(index)
				}
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
			.frame(height: 150)
			
			HStack(spacing: 0) {
				Button {
					appState.myOrders[selectedOrderIndex].status = .done
					showNextOrder()
				} label: {
					Text("Yes")
						.font(.alata(fixedSize: 18))
						.frame(width: 134, height: 44)
						.background(Color.oliveSecondary, in: Capsule())
						.contentShape(Capsule())
					
				}
				.buttonStyle(.plain)
				
				Spacer()
				
				Button {
					appState.myOrders[selectedOrderIndex].status = .created
					showNextOrder()
				} label: {
					Text("No")
						.font(.alata(fixedSize: 18))
						.frame(width: 134, height: 44)
						.background(Color.oliveSecondary, in: Capsule())
						.contentShape(Capsule())
					
				}
				.buttonStyle(.plain)
				
			}
			.padding(.top, 50)
			.padding(.horizontal, 43)
			
			Spacer()
		}
	}
	
	private func showNextOrder() {
		let nextIndex = selectedOrderIndex + 1
		if nextIndex < appState.myOrders.count {
			withAnimation {
				selectedOrderIndex = nextIndex
			}
		}
	}
}

#Preview {
	CheckCleaningView()
		.environmentObject(Router())
		.environmentObject(AppState())
}
