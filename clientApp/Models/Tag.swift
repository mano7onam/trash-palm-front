//
//  Tag.swift
//  clientApp
//
//  Created by Andrey Matveev on 26.11.2023.
//

import Foundation

enum TagType: String, Decodable {
    case user = "USER"
    case challenge = "CHALLENGE"
}

enum TagStatus: String, Decodable {
    case active = "ACTIVE"
    case processing = "PROCESSING"
    case finished = "FINISHED"
}

struct Tag: Transactionable, Decodable {
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
}
