//
//  TrashListView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 26/11/2023.
//

import Foundation
import SwiftUI

struct TrashListView: View {
	
	@EnvironmentObject var vm: AppState
	
	@State private var searchText = ""
	
	var body: some View {
		VStack {
			HStack {
				TextField("Search", text: $searchText)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.padding()
				
				Image(systemName: "person.crop.circle")
					.resizable()
					.foregroundColor(.olive)
					.frame(width: 40, height: 40)
					.padding()
			}
			
			Text("List of garbage")
				.font(.palmTitle)
			
			TabView {
                ForEach(vm.allTrashLists) { item in
                    NavigationLink(destination: TrashListDetails(item: item)) {
                        VStack {
                            Text(item.text)
                                .bold()
                                .font(.palmRegular22)
                                .foregroundColor(.sunny)
                            Image(item.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 450)
                        }
                        .background(Color.oliveSecondary.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.oliveSecondary, lineWidth: 2))
                        .frame(width: 400, height: 700)
                    }
                }
			}
				.tabViewStyle(PageTabViewStyle())
				.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
		}
	}
}

#Preview {
    TrashListView().environmentObject(AppState())
}
