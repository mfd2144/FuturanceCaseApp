//
//  TradeInteractor.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 24.08.2022.
//

import Foundation
import Combine

final class TradeInteractor: TradeInteractorProtocol {
    weak var presenter: TradeInteractorDelegate?
    
    func load() {
        appContainer.manager.getCurrencies(kind: .binance) {[weak self] currency, error in
            guard let self = self else { return }
            if let error = error {
                self.presenter?.handleInteractorOutputs(.isLoading(false))
                self.presenter?.handleInteractorOutputs(.anyError(.fetchingBinanceDataError(error)))
            } else {
                guard let currency = currency else { return } // todo caution
                // Filtered pairs which are include TRY
                let tryFilteredData = currency.filter({ $0.symbol.contains("TRY") })
                self.presenter?.handleInteractorOutputs(.returnCurrenciesData(tryFilteredData))
            }
        }
        appContainer.manager.getCurrencyInformations(kind: .gecko) { otherInformations, error in
            if let error = error {
                self.presenter?.handleInteractorOutputs(.anyError(.fetchingOtherInformationsError(error)))
            } else {
                guard let otherInformations = otherInformations else { return } // todo caution
                // Filtered pairs which are include TRY
                self.presenter?.handleInteractorOutputs(.returnOtherInformations(otherInformations))
            }
        }
    }
    
    func buyPressed(for qty: Double, from currecyType: String) {
        
    }
    
    func sellPressed(for qty: Double, to currecyType: String) {
        
    }
}
