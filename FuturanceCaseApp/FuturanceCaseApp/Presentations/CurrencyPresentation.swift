//
//  CurrencyModel.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 24.08.2022.
//

import Foundation
import struct NetworkLayer.Currency

struct CurrencyPresentation {
    let symbolFrom: String
    let symbolTo: String
    let priceChangePercent: Double
    let lastPrice: Double
    let lowPrice: Double
    let highPrice: Double
    var image: String?
    var name: String?
}
extension CurrencyPresentation {
    init(_ currrency: Currency) throws {
        self.symbolFrom = currrency.symbol.replacingOccurrences(of: "TRY", with: "")
        self.symbolTo = "TYR"
        guard let priceChangePercentDouble = Double(currrency.priceChangePercent),
              let lastPriceDouble = Double(currrency.lastPrice),
              let lowPriceDouble = Double(currrency.lowPrice),
              let highPriceDouble = Double(currrency.highPrice) else {
            throw FuturanceError.convertPresentationError(currrency.symbol)
        }
        
        self.highPrice = highPriceDouble
        self.lowPrice = lowPriceDouble
        self.priceChangePercent = priceChangePercentDouble
        self.lastPrice = lastPriceDouble
    }
}
