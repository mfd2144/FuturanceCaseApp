//
//  CurrencyModel.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation

public struct Currency: Decodable {
    let symbol: String
    let priceChange: String
    let priceChangePercent: String
    let weightedAvgPrice: String
    let prevClosePrice: String
    let lastPrice: String
    let lastQty: String
    let bidPrice: String
    let bidQty: String
    let askPrice: String
    let askQty: String
    let openPrice: String
    let highPrice: String
    let lowPrice: String
    let volume: String
    let quoteVolume: String
    let openTime: Int
    let closeTime: Int
    let firstId: Int
    let lastId: TimeInterval
    let count: TimeInterval
}


//{
//  "symbol": "BNBBTC",
//  "priceChange": "-94.99999800",
//  "priceChangePercent": "-95.960",
//  "weightedAvgPrice": "0.29628482",
//  "prevClosePrice": "0.10002000",
//  "lastPrice": "4.00000200",
//  "lastQty": "200.00000000",
//  "bidPrice": "4.00000000",
//  "bidQty": "100.00000000",
//  "askPrice": "4.00000200",
//  "askQty": "100.00000000",
//  "openPrice": "99.00000000",
//  "highPrice": "100.00000000",
//  "lowPrice": "0.10000000",
//  "volume": "8913.30000000",
//  "quoteVolume": "15.30000000",
//  "openTime": 1499783499040,
//  "closeTime": 1499869899040,
//  "firstId": 28385,   // First tradeId
//  "lastId": 28460,    // Last tradeId
//  "count": 76         // Trade count
//}
