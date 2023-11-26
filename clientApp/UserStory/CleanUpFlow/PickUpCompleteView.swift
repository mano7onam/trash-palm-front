//
//  PickUpCompleteView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import SwiftUI

struct PickUpCompleteView: View {
	@Environment(\.dismiss) var dismiss
	
	var body: some View {
        VStack {
            Spacer()
            Text("You did it!!!")
                .font(.title)
            Spacer().frame(height: 20)
            Text("You earned N tokens")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            
            Image("girl")
                .aspectRatio(contentMode: .fit)
            Spacer()
            Button(action: dismiss.callAsFunction) {
                Text("Finish")
                    .bold()
                    .padding()
                    .frame(minWidth: 200)
                    .background(Color.olive)
                    .foregroundColor(.white)
                    .clipShape(RoundedCorners(tl: 0, tr: 30, bl: 30, br: 30))
                
            }
            Spacer()
        }
	}
}

#Preview {
    PickUpCompleteView().environmentObject(AppState())
}
