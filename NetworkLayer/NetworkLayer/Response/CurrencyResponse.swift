//
//  CurrencyResponse.swift
//  FuturanceCaseAppTests
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation

public struct CurrencyResponse: Decodable {
    var result: [Currency]
    
    public init(from decoder: Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()
        result = try singleValueContainer.decode([Currency].self)
    }
}
