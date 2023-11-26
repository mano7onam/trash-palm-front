//
//  BalanceAmountView.swift
//  clientApp
//
//  Created by Stanislav Zelikson on 26/11/2023.
//

import Foundation
import SwiftUI


struct BalanceAmountView: View {
    
    @State var balanceType: BalanceType
    
    var mainColor: Color {
        switch balanceType {
        case .nft: return .oliveSecondary
        case .tokens: return .sunny
        }
    }
    
    init(balanceType: BalanceType) {
        self.balanceType = balanceType
    }
    
    var body: some View {
        VStack {
            Text("Amount")
                .font(.palmTitle)
            Image(balanceType == .nft ? "sunny_palm" : "money_grow")
                .frame(width: 200, height: 200)
                .background(mainColor)
                .clipShape(Circle())
            ZStack {
                RoundedRectangle(cornerRadius: 30, style: .circular)
                    .frame(width: 350, height: 300)
                    .foregroundColor(mainColor)

                Circle()
                    .frame(width: 140)
                    .foregroundColor(mainColor)
                    .padding(.top, -190)
                VStack {
                    Picker("Please choose a period", selection: $balanceType) {
                        ForEach(BalanceType.allCases, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(60)
                        .padding(.top, -140)
                    Text(balanceType == .tokens ? "100 Tokens" : "4 NFT")
                        .font(.palmTitle30)
                    if balanceType == .nft {
                        NavigationLink(destination: NftCollectionView()) {
                            Text("Show more")
                                .foregroundColor(.white)
                                .font(.palmRegular)
                        }
                    }
                }
            }.padding(.top, 60)
            Spacer()
        }
    }
}

#Preview {
    BalanceAmountView(balanceType: .nft)
}
