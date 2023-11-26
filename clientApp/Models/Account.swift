//
//  Account.swift
//  clientApp
//
//  Created by Andrey Matveev on 26.11.2023.
//

import Foundation

struct Account: Transactionable, Decodable {
    let email: String
    let cryptoId: String
    let cryptoPrivateKey: String
    let name: String
    var balance: Int64
    var nfts: [Nft]
}
