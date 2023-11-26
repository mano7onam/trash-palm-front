//
//  Tag.swift
//  clientApp
//
//  Created by Andrey Matveev on 26.11.2023.
//

import Foundation

enum TagType: String, Decodable, Hashable {
    case user = "USER"
    case challenge = "CHALLENGE"
}

enum TagStatus: String, Decodable, Hashable {
    case active = "ACTIVE"
    case processing = "PROCESSING"
    case finished = "FINISHED"
}

struct Tag: Transactionable, Decodable, Hashable {
    let id: String
    let lon: Double
    let lat: Double
    let title: String
    let description: String
    let owner: String
    let cryptoId: String
    let cryptoPrivateKey: String
    var prize: Int64
    var photoUrls: [String]
    var type: TagType
    var comments: [String]
    var status: TagStatus
    var claimer: String?
    var voters: [String]
    
    static func mock() -> Self {
        Tag(
            id: "1",
            lon: 0.0,
            lat: 0.0,
            title: "Title",
            description: "Description",
            owner: "Owner",
            cryptoId: "CryptoId",
            cryptoPrivateKey: "CryptoPrivateKey",
            prize: 1000,
            photoUrls: ["url1", "url2"],
            type: .challenge, // Замените на ваш тип TagType
            comments: ["Comment1", "Comment2"],
            status: .active, // Замените на ваш статус TagStatus
            claimer: "Claimer",
            voters: ["Voter1", "Voter2"]
        )
    }
}
