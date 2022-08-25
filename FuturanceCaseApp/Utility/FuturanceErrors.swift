//
//  FuturanceErrors.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 24.08.2022.
//

import Foundation

enum FuturanceError: Error {
    case convertPresentationError(String)
    case fetchingBinanceDataError(String)
    case fetchingOtherInformationsError(String)
    
    var localDescription: String {
        switch self {
        case .convertPresentationError(let symbol):
           return "\(symbol) data convert hatası"
        case .fetchingBinanceDataError(let error):
            return "Binance adresinden yükleme hatası: \(error)"
        case.fetchingOtherInformationsError(let error):
            return "Coinlerin ikonlarının adresleri çekilemedi: \(error)"
        }
    }
}
