//
//  CurrencyOtherInfos.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 25.08.2022.
//

import Foundation

public struct CurrencyOtherInformations: Decodable {
    public let image: String
    public let symbol: String
    public let name: String
}
extension CurrencyOtherInformations: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.symbol)
    }
    
    public static func == (lhs: CurrencyOtherInformations, rhs: CurrencyOtherInformations) -> Bool {
        return lhs.symbol == rhs.symbol
    }
}
