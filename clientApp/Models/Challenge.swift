//
//  Challenge.swift
//  clientApp
//
//  Created by Andrey Matveev on 26.11.2023.
//

import Foundation

enum ChallengeStatus: String {
    case active = "ACTIVE"
    case processing = "PROCESSING"
    case finished = "FINISHED"
}

struct Challenge: Transactionable {
    let id: String
    let title: String
    let description: String
    var tagIds: [String]
    var nfts: [Nft]
    var deadline: Date
    var status: ChallengeStatus
    var cryptoId: String
    var cryptoPrivateKey: String
}
