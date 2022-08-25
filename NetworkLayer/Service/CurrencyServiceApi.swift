//
//  CurrencyServiceApi.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation
import Alamofire

enum CurrencyAPI {
    case binance
    case image(String)
    case gecko
}

extension CurrencyAPI: HTTPEndPointType {
    var baseURL: String{
        switch self {
        case .binance:
            return  "https://www.binance.com"
        case .image(let imageURL):
           return imageURL
        case .gecko:
            return "https://api.coingecko.com"
        }
    }
    
    var path: String{
        switch self {
        case .binance:
          return "/api/v3/ticker/24hr"
        case.image:
            return ""
        case.gecko:
            return "/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc"
        }
    }
    
    var header: HTTPHeaders?{
        switch self {
        case .binance, .image, .gecko:
            return nil
        }
    }
    
    var method: HTTPMethod{
        .get
    }
    
    var param: Parameters?{
        nil
    }
}

