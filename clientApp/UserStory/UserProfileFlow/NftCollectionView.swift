//
//  NftCollectionView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 26/11/2023.
//

import Foundation
import SwiftUI

struct NftCollectionView: View {
	
	@EnvironmentObject var vm: AppState
	
	var body: some View {
		VStack {
			Text("NFT Assets")
				.font(.palmTitle)
			TabView {
				ForEach(vm.allNftAssets) { asset in
					VStack {
                        Image(asset.imageName)
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 367, height: 300)
                        Text(asset.text)
							.font(.palmRegular22)
					}
				}
			}
				.tabViewStyle(PageTabViewStyle())
				.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
			
			
		}
	}
}

#Preview {
    NftCollectionView()
}
