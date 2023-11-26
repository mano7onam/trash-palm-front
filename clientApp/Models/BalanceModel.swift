//
//  BalanceModel.swift
//  clientApp
//
//  Created by Stanislav Zelikson on 26/11/2023.
//

import Foundation

enum BalanceType: String, Identifiable, CaseIterable {
    case nft = "NFT"
    case tokens = "Tokens"
    
    var id: String {
        rawValue
    }
}
