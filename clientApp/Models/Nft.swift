//
//  Nft.swift
//  clientApp
//
//  Created by Andrey Matveev on 26.11.2023.
//

import Foundation

struct Nft: Equatable, Decodable {
    let id: String
    let data: Data
    let value: Int64

    static func ==(lhs: Nft, rhs: Nft) -> Bool {
        return lhs.id == rhs.id
    }
}
