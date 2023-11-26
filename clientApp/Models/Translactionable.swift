//
//  Translactionable.swift
//  clientApp
//
//  Created by Andrey Matveev on 26.11.2023.
//

import Foundation

protocol Transactionable {
    var cryptoId: String { get }
    var cryptoPrivateKey: String { get }
}
