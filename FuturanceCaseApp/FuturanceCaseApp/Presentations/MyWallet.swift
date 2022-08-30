//
//  MyWallet.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 26.08.2022.
//

import Foundation

struct MyWallet: Codable {
    var entities: [Entity]
    
    init(entities: [Entity]) {
        self.entities = entities
    }
}

struct Entity: Codable {
    let name: String
    var amount: Double
}
